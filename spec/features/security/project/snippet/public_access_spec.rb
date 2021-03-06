require 'spec_helper'

describe "Public Project Snippets Access", feature: true  do
  include AccessMatchers

  let(:project) { create(:project, :public) }

  let(:owner)     { project.owner }
  let(:master)    { create(:user) }
  let(:developer) { create(:user) }
  let(:reporter)  { create(:user) }
  let(:guest)     { create(:user) }
  let(:public_snippet)   { create(:project_snippet, :public, project: project, author: owner) }
  let(:internal_snippet) { create(:project_snippet, :internal, project: project, author: owner) }
  let(:private_snippet)  { create(:project_snippet, :private, project: project, author: owner) }

  before do
    project.team << [master, :master]
    project.team << [developer, :developer]
    project.team << [reporter, :reporter]
    project.team << [guest, :guest]
  end

  describe "GET /:project_path/snippets" do
    subject { namespace_project_snippets_path(project.namespace, project) }

    it { is_expected.to be_allowed_for :admin }
    it { is_expected.to be_allowed_for owner }
    it { is_expected.to be_allowed_for master }
    it { is_expected.to be_allowed_for developer }
    it { is_expected.to be_allowed_for reporter }
    it { is_expected.to be_allowed_for guest }
    it { is_expected.to be_allowed_for :user }
    it { is_expected.to be_allowed_for :external }
    it { is_expected.to be_allowed_for :visitor }
  end

  describe "GET /:project_path/snippets/new" do
    subject { new_namespace_project_snippet_path(project.namespace, project) }

    it { is_expected.to be_allowed_for :admin }
    it { is_expected.to be_allowed_for owner }
    it { is_expected.to be_allowed_for master }
    it { is_expected.to be_allowed_for developer }
    it { is_expected.to be_allowed_for reporter }
    it { is_expected.to be_denied_for guest }
    it { is_expected.to be_denied_for :user }
    it { is_expected.to be_denied_for :external }
    it { is_expected.to be_denied_for :visitor }
  end

  describe "GET /:project_path/snippets/:id for a public snippet" do
    subject { namespace_project_snippet_path(project.namespace, project, public_snippet) }

    it { is_expected.to be_allowed_for :admin }
    it { is_expected.to be_allowed_for owner }
    it { is_expected.to be_allowed_for master }
    it { is_expected.to be_allowed_for developer }
    it { is_expected.to be_allowed_for reporter }
    it { is_expected.to be_allowed_for guest }
    it { is_expected.to be_allowed_for :user }
    it { is_expected.to be_allowed_for :external }
    it { is_expected.to be_allowed_for :visitor }
  end

  describe "GET /:project_path/snippets/:id for an internal snippet" do
    subject { namespace_project_snippet_path(project.namespace, project, internal_snippet) }

    it { is_expected.to be_allowed_for :admin }
    it { is_expected.to be_allowed_for owner }
    it { is_expected.to be_allowed_for master }
    it { is_expected.to be_allowed_for developer }
    it { is_expected.to be_allowed_for reporter }
    it { is_expected.to be_allowed_for guest }
    it { is_expected.to be_allowed_for :user }
    it { is_expected.to be_denied_for :external }
    it { is_expected.to be_denied_for :visitor }
  end

  describe "GET /:project_path/snippets/:id for a private snippet" do
    subject { namespace_project_snippet_path(project.namespace, project, private_snippet) }

    it { is_expected.to be_allowed_for :admin }
    it { is_expected.to be_allowed_for owner }
    it { is_expected.to be_allowed_for master }
    it { is_expected.to be_allowed_for developer }
    it { is_expected.to be_allowed_for reporter }
    it { is_expected.to be_allowed_for guest }
    it { is_expected.to be_denied_for :user }
    it { is_expected.to be_denied_for :external }
    it { is_expected.to be_denied_for :visitor }
  end
end
