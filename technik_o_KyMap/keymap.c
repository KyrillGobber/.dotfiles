/* Copyright 2020 Boardsource
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include QMK_KEYBOARD_H
#include <keymap_extras/keymap_german_ch.h>


const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {

  [0] = LAYOUT_ortho_4x12(
  //,-----------------------------------------------------------------------------------------------------------.
       KC_TAB,    KC_Q,    KC_W,    KC_E,    KC_R,    KC_T,    CH_Z,    KC_U,    KC_I,    KC_O,    KC_P, KC_BSPC,
  //|--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------|
      MT(MOD_LCTL, KC_ESC),    KC_A,    KC_S,    KC_D,    KC_F,    KC_G,    KC_H,    KC_J,    KC_K,    KC_L, CH_ODIA, CH_ADIA,
  //|--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------|
      KC_LSFT,    CH_Y,    KC_X,    KC_C,    KC_V,    KC_B,    KC_N,    KC_M, CH_COMM,  CH_DOT, CH_MINS, KC_RSFT,
  //|--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------|
        MO(3), KC_LALT,  OSL(4), KC_LGUI,   MO(2),  KC_ENT,  KC_SPC,   MO(1), KC_RALT,  OSL(4),   MO(3),  KC_ENT
  //|--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------|
  ),

  [1] = LAYOUT_ortho_4x12(
  //,-----------------------------------------------------------------------------------------------------------.
      CH_SECT, CH_BSLS, CH_SLSH, CH_LPRN, CH_RPRN, XXXXXXX, KC_PGUP, KC_HOME,   KC_UP,  KC_END, CH_UDIA,  KC_DEL,
  //|--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------|
      KC_LCTL,   CH_AT, CH_HASH, CH_LCBR, CH_RCBR, XXXXXXX, KC_PGDN, KC_LEFT, KC_DOWN, KC_RGHT, CH_QUES, CH_EXLM,
  //|--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------|
      KC_LSFT, CH_LABK, CH_RABK, CH_LBRC, CH_RBRC, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,  CH_GRV,  CH_DLR, XXXXXXX,
  //|--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------|
      XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,    TG(5)
  //|--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------|
  ),

  [2] = LAYOUT_ortho_4x12(
  //,-----------------------------------------------------------------------------------------------------------.
       KC_ESC,    CH_1,    CH_2,    CH_3,    CH_4,    CH_5,    CH_6,    CH_7,    CH_8,    CH_9,    CH_0, CH_QUOT,
  //|--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------|
      KC_LCTL,   KC_F1,   KC_F2,   KC_F3,   KC_F4,   KC_F5,   KC_F6,   KC_F7,   KC_F8,   KC_F9,  KC_F10,  KC_F11,
  //|--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------|
      KC_LSFT, CH_PLUS, CH_DQUO, CH_ASTR, CH_AMPR, CH_PERC, XXXXXXX, CH_DQUO,  CH_EQL, CH_QUES, CH_EXLM,  KC_F12,
  //|--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------|
      RGB_TOG, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX
  //|--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------|
  ),

  [3] = LAYOUT_ortho_4x12(
  //,-----------------------------------------------------------------------------------------------------------.
      KC_ACL0, XXXXXXX, KC_BTN1, KC_MS_U, KC_BTN2, KC_WH_U, KC_PAST,    CH_7,    CH_8,    CH_9, KC_PMNS, KC_BSPC,
  //|--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------|
      KC_ACL1, XXXXXXX, KC_MS_L, KC_MS_D, KC_MS_R, KC_WH_D, KC_PSLS,    CH_4,    CH_5,    CH_6, KC_PPLS, XXXXXXX,
  //|--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------|
      KC_ACL2, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,    CH_1,    CH_2,    CH_3, XXXXXXX, XXXXXXX,
  //|--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------|
      XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, KC_PENT,    CH_0, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX
  //|--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------|
  ),

  [4] = LAYOUT_ortho_4x12(
  //,-----------------------------------------------------------------------------------------------------------.
      XXXXXXX, CH_PLUS, CH_DQUO, CH_ASTR, CH_CCED, CH_PERC, CH_AMPR, CH_SLSH, CH_LPRN, CH_RPRN,  CH_EQL, CH_QUOT,
  //|--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------|
      XXXXXXX, CH_BRKP,   CH_AT, CH_EURO, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,  CH_DLR, CH_ACUT,
  //|--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------|
      XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,  CH_DLR, CH_TILD,
  //|--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------|
      XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, CH_TILD
  //|--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------|
  ),

  [5] = LAYOUT_ortho_4x12(
  //,-----------------------------------------------------------------------------------------------------------.
       KC_TAB,    CH_2,    KC_Q,    KC_W,    KC_E,    KC_R, KC_PGUP, KC_HOME,   KC_UP,  KC_END, CH_UDIA,  KC_DEL,
  //|--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------|
         KC_B,    CH_1,    KC_A,    KC_S,    KC_D,    KC_F, KC_PGDN, KC_LEFT, KC_DOWN, KC_RGHT, CH_QUES, CH_EXLM,
  //|--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------|
      KC_LSFT, KC_LCTL,MT(KC_G, KC_Y),    KC_X,    KC_C,    KC_V, XXXXXXX, XXXXXXX, XXXXXXX,  CH_GRV,  CH_DLR, XXXXXXX,
  //|--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------|
      KC_LSFT, KC_LCTL, XXXXXXX,    CH_3,    CH_4,  KC_SPC, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,   TG(5),  KC_ESC
  //|--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------|
  )

//  [4] = LAYOUT_ortho_4x12(
  //,-----------------------------------------------------------------------------------------------------------.
//      XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
  //|--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------|
//      XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
  //|--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------|
//      XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
  //|--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------|
//      XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX
  //|--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------|
//  )

};




















