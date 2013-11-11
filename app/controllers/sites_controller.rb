#coding: utf-8
class SitesController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :build_produc_url

  # GET /sites
  # GET /sites.json
  def index
    @sites = Site.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sites }
    end
  end

  # GET /sites/1
  # GET /sites/1.json
  def show
    @site = Site.find(params[:id])

    @links = if @site.links.joins(:products).where(products: {url: params[:product_url]}).present?
               @site.links.joins(:products).where(products: {url: params[:product_url]})
             else
               @site.links
             end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @links.shuffle.first(3), callback: params[:callback] }
    end
  end

  # GET /sites/new
  # GET /sites/new.json
  def new
    @site = Site.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @site }
    end
  end

  # GET /sites/1/edit
  def edit
    @site = Site.find(params[:id])
  end

  # POST /sites
  # POST /sites.json
  def create
    @site = Site.new(params[:site])

    respond_to do |format|
      if @site.save
        format.html { redirect_to @site, notice: 'Site was successfully created.' }
        format.json { render json: @site, status: :created, location: @site }
      else
        format.html { render action: "new" }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sites/1
  # PUT /sites/1.json
  def update
    @site = Site.find(params[:id])

    respond_to do |format|
      if @site.update_attributes(params[:site])
        format.html { redirect_to @site, notice: 'Site was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  def import
    @site = Site.find(params[:id])
    Link.import(params[:file], @site.id)
    redirect_to site_path(@site), notice: "Импортнулось как надо"
  end

  def build_product_url
    links = Link.where(id: params[:ids])
    links.each do |link|
      link.products.build(url: params[:product_url])
      link.save!
    end
    redirect_back
  end

  # DELETE /sites/1
  # DELETE /sites/1.json
  def destroy
    @site = Site.find(params[:id])
    @site.destroy

    respond_to do |format|
      format.html { redirect_to sites_url }
      format.json { head :no_content }
    end
  end
end
