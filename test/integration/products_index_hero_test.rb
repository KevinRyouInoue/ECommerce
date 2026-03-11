require "test_helper"

class ProductsIndexHeroTest < ActionDispatch::IntegrationTest
  test "products index shows the dating style hero card" do
    get root_url

    assert_response :success
    assert_select "section.dating-hero" do
      assert_select "h1", text: "Dinner date energy, but make it candid."
      assert_select "img.dating-hero__image[alt='Dating profile style dinner portrait']"
      assert_select ".dating-hero__chips span", minimum: 3
    end
  end
end
