import { Given, When, Then } from "@wdio/cucumber-framework";
import { expect, $, $$, browser } from "@wdio/globals";

const targetUrl = "https://www.saucedemo.com/";

Given("I am on the swaglabs application page", async () => {
  await browser.url(targetUrl);
});

When("I login to the application", async () => {
  const correctCredentials = {
    user: "standard_user",
    pass: "secret_sauce",
  };
  await (await $("#user-name")).setValue(correctCredentials.user);
  await (await $("#password")).setValue(correctCredentials.pass);
  await (await $("#login-button")).click();
});

When(
  "I try to login to the application with incorrect credentials",
  async () => {
    const incorrectCredentials = {
      user: "incorrect_user",
      pass: "incorrect_secret",
    };
    await (await $("#user-name")).setValue(incorrectCredentials.user);
    await (await $("#password")).setValue(incorrectCredentials.pass);
    await (await $("#login-button")).click();
  },
);

When("I select a product", async () => {
  await (await $(".inventory_item_img")).click();
});

When("I add a product to my cart", async () => {
  const addToCartButton = await $("button*=Add to cart");
  await addToCartButton.waitForExist();
  await addToCartButton.waitForClickable();
  await addToCartButton.click();
});

When("I logout of the application", async () => {
  // First we find and click on the burger menu
  const burgerMenuBtn = await $("#react-burger-menu-btn");
  expect(await burgerMenuBtn.waitForClickable()).toBeTruthy();
  await burgerMenuBtn.click();

  // Then when entries appear we click on logout
  const logoutBtn = await $("#logout_sidebar_link");
  expect(await logoutBtn.waitForClickable()).toBeTruthy();
  await logoutBtn.click();
});

Then("I should see the six product list items", async () => {
  const items = await $$(".inventory_item");
  items.forEach((it) => {
    it.waitForExist();
  });

  // Then we test the expectations
  expect(items).toHaveLength(6);
});

Then("I should see login error message", async () => {
  const errorContainer = await $(".error-message-container.error");
  await errorContainer.waitForExist();

  const errorContainerTextMessage = await errorContainer.getText();
  const expectedMessage =
    "Epic sadface: Username and password do not match any user in this service";

  // Then we test the expectations
  expect(errorContainerTextMessage).toContain(expectedMessage);
});

Then("I should see the product details", async () => {
  const url = await browser.getUrl();
  expect(url).toContain("inventory-item.html");
  const backToProductsButton = await $(
    '//button[@data-test="back-to-products"]',
  );
  expect(backToProductsButton).toExist();
  expect(await backToProductsButton.waitForDisplayed()).toBeTruthy();
});

Then("I should see the cart update with the added product", async () => {
  const cartElement = await $(".shopping_cart_badge");
  await cartElement.waitForExist();
  expect(await cartElement.getText()).toEqual("1");
});

Then("I should be able to see my cart page", async () => {
  const cartIcon = await $(".shopping_cart_link");
  expect(await cartIcon.waitForClickable()).toBeTruthy();
  await cartIcon.click();
  const cartPageTitle = await $("span*=Your Cart");
  expect(await cartPageTitle.waitForDisplayed()).toBeTruthy();
  const url = await browser.getUrl();
  expect(url).toContain("cart.html");
});

Then("I should be able to check out item", async () => {
  const cartIcon = await $(".shopping_cart_link");
  expect(await cartIcon.waitForClickable()).toBeTruthy();
  await cartIcon.click();
  const checkoutButton = await $("button*=Checkout");
  await checkoutButton.waitForClickable();
  await checkoutButton.click();
});

Then("I should see the login option available", async () => {
  expect(await $("#user-name")).toExist();
  expect(await $("#password")).toExist();
  expect(await $("#login-button")).toBeClickable();
});
