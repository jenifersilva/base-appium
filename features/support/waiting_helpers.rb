# frozen_string_literal: true

# Waiting methods helpers
module WaitingHelpers
  def self.wait_for_element_be_enabled(element, timeout = 15)
    wait = Selenium::WebDriver::Wait.new timeout: timeout
    begin
      wait.until { find_element(element).enabled? }
    rescue StandardError
      p "[warn] timed out waiting #{element} be enabled."
    end
  end

  def self.wait_for_element_be_displayed(element, timeout = 15)
    wait = Selenium::WebDriver::Wait.new timeout: timeout
    begin
      wait.until { find_element(element).displayed? }
    rescue StandardError
      p "[warn] timed out waiting #{element} be displayed."
    end
  end

  def self.wait_for_element_not_be_displayed(element, timeout = 15)
    wait = Selenium::WebDriver::Wait.new timeout: timeout
    begin
      wait.until { find_element(element).displayed?.eql? false }
    rescue Selenium::WebDriver::Error::NoSuchElementError, Selenium::WebDriver::Error::StaleElementReferenceError,
           StandardError
      false
    end
  end

  def self.wait_for_text_be_displayed(element, text, timeout = 40)
    wait = Selenium::WebDriver::Wait.new timeout: timeout
    wait.until { find_elements(element).any? { |el| el.text.eql? text } }
  end

  def self.element_displayed?(element)
    find_element(element).displayed?
  rescue Selenium::WebDriver::Error::NoSuchElementError, Selenium::WebDriver::Error::StaleElementReferenceError
    false
  end

  def self.element_enabled?(element)
    find_element(element).enabled?
  rescue Selenium::WebDriver::Error::NoSuchElementError, Selenium::WebDriver::Error::StaleElementReferenceError
    false
  end

  def self.text_displayed?(element, text, index = 0)
    find_elements(element)[index].text.eql? text
  rescue StandardError
    false
  end
end
