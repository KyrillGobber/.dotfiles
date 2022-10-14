/*
Copyright 2019 @foostan
Copyright 2020 Drashna Jaelre <@drashna>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#include QMK_KEYBOARD_H
#include <keymap_extras/keymap_german_ch.h>
#include <stdio.h>

#define L_MAIN 0
#define L_LOWER 1
#define L_RAISE 2
#define L_MOUSE 3
#define L_GAMING 4
#define L_OSL 5

// Define a type for as many tap dance states as you need
typedef enum {
    TD_NONE,
    TD_UNKNOWN,
    TD_SINGLE_TAP,
    TD_SINGLE_HOLD,
    TD_DOUBLE_TAP
} td_state_t;

typedef struct {
    bool is_press_action;
    td_state_t state;
} td_tap_t;

// Tap Dance declarations
enum {
	TD_1,
	TD_2,
	FN,
	ESC
};

// Declare the functions to be used with your tap dance keys
// Function associated with all tap dances
td_state_t cur_dance(qk_tap_dance_state_t *state);

// Functions associated with individual tap dances
void ql_finished(qk_tap_dance_state_t *state, void *user_data);
void ql_reset(qk_tap_dance_state_t *state, void *user_data);

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
  [L_MAIN] = LAYOUT_split_3x6_3(
  //,-----------------------------------------------------.                    ,-----------------------------------------------------.
       KC_TAB,    KC_Q,    KC_W,    KC_E,    KC_R,    KC_T,                         CH_Z,    KC_U,    KC_I,    KC_O,   KC_P,  KC_BSPC,
  //|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
      KC_LCTL,    KC_A,    KC_S,    KC_D,    KC_F,    KC_G,                         KC_H,    KC_J,    KC_K,    KC_L, CH_ODIA, CH_ADIA,
  //|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
      KC_LSFT,    CH_Y,    KC_X,    KC_C,    KC_V,    KC_B,                         KC_N,    KC_M, CH_COMM,  CH_DOT, CH_MINS, KC_RSFT,
  //|--------+--------+--------+--------+--------+--------+--------|  |--------+--------+--------+--------+--------+--------+--------|
                                          KC_LGUI,   MO(2),  KC_ENT,     KC_SPC, TD(TD_1), TD(TD_2)
                                      //`--------------------------'  `--------------------------'
  ),

  [L_LOWER] = LAYOUT_split_3x6_3(
  //,-----------------------------------------------------.                    ,-----------------------------------------------------.
      CH_SECT, CH_BSLS, CH_SLSH, CH_LPRN, CH_RPRN, XXXXXXX,                      KC_PGUP, KC_HOME,   KC_UP,  KC_END, CH_UDIA,  KC_DEL,
  //|--------+--------+--------+--------+--------+--------|       	           |--------+--------+--------+--------+--------+--------|
      KC_LCTL,   CH_AT, CH_HASH, CH_LCBR, CH_RCBR, XXXXXXX,                      KC_PGDN, KC_LEFT, KC_DOWN, KC_RGHT, CH_QUES, CH_EXLM,
  //|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
      KC_LSFT, CH_LABK, CH_RABK, CH_LBRC, CH_RBRC, XXXXXXX,                      XXXXXXX, XXXXXXX, XXXXXXX,  CH_GRV,  CH_DLR, XXXXXXX,
  //|--------+--------+--------+--------+--------+--------+--------|  |--------+--------+--------+--------+--------+--------+--------|
                                          KC_LGUI, KC_LALT, XXXXXXX,    XXXXXXX, _______, TG(4)
                                      //`--------------------------'  `--------------------------'
  ),

  [L_RAISE] = LAYOUT_split_3x6_3(
  //,-----------------------------------------------------.                    ,-----------------------------------------------------.
       KC_ESC,    CH_1,    CH_2,    CH_3,    CH_4,    CH_5,                         CH_6,    CH_7,    CH_8,    CH_9,    CH_0, CH_QUOT,
  //|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
      KC_LCTL,   KC_F1,   KC_F2,   KC_F3,   KC_F4,   KC_F5,                        KC_F6,   KC_F7,   KC_F8,   KC_F9,  KC_F10,  KC_F11,
  //|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
      KC_LSFT, CH_PLUS, CH_DQUO, CH_ASTR, CH_AMPR, CH_PERC,                      XXXXXXX, CH_DQUO,  CH_EQL, CH_QUES, CH_EXLM,  KC_F12,
  //|--------+--------+--------+--------+--------+--------+--------|  |--------+--------+--------+--------+--------+--------+--------|
                                          XXXXXXX, _______,   MO(3),    XXXXXXX, XXXXXXX, TG(4)
                                      //`--------------------------'  `--------------------------'
  ),


  [L_MOUSE] = LAYOUT_split_3x6_3(
  //,-----------------------------------------------------.                    ,-----------------------------------------------------.
      KC_ACL0, XXXXXXX, KC_BTN1, KC_MS_U, KC_BTN2, KC_WH_U,                      KC_PAST,    CH_7,    CH_8,    CH_9, KC_PPLS, KC_BSPC,
  //|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
      KC_ACL1, XXXXXXX, KC_MS_L, KC_MS_D, KC_MS_R, KC_WH_D,                      KC_PSLS,    CH_4,    CH_5,    CH_6, KC_PMNS, XXXXXXX,
  //|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
      KC_ACL2, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,                      XXXXXXX,    CH_1,    CH_2,    CH_3, XXXXXXX, XXXXXXX,
  //|--------+--------+--------+--------+--------+--------+--------|  |--------+--------+--------+--------+--------+--------+--------|
                                          XXXXXXX, _______, _______,    KC_PENT,    CH_0, XXXXXXX
                                      //`--------------------------'  `--------------------------'
  ),
  
    [L_GAMING] = LAYOUT_split_3x6_3(
  //,-----------------------------------------------------.                    ,-----------------------------------------------------.
      TD(ESC),    CH_2,    KC_Q,    KC_W,    KC_E,    KC_R,                      XXXXXXX, XXXXXXX,   KC_UP, XXXXXXX, XXXXXXX, XXXXXXX,
  //|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
         CH_B,    CH_1,    KC_A,    KC_S,    KC_D,    KC_F,                      XXXXXXX, KC_LEFT, KC_DOWN, KC_RGHT, XXXXXXX, XXXXXXX,
  //|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
      KC_LSFT, KC_LCTL,  TD(FN),    KC_X,    KC_C,    KC_V,                      XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
  //|--------+--------+--------+--------+--------+--------+--------|  |--------+--------+--------+--------+--------+--------+--------|
                                             CH_3,    CH_4, KC_SPC,      KC_ESC, XXXXXXX, TG(4)
                                      //`--------------------------'  `--------------------------'
  ),
  
    [L_OSL] = LAYOUT_split_3x6_3(
  //,-----------------------------------------------------.                    ,-----------------------------------------------------.
      XXXXXXX, CH_PLUS, CH_DQUO, CH_ASTR, CH_CCED, CH_PERC,                      CH_AMPR, CH_SLSH, CH_LPRN, CH_RPRN,  CH_EQL, CH_QUOT,
  //|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
      XXXXXXX, CH_BRKP,   CH_AT, CH_EURO, XXXXXXX, XXXXXXX,                      XXXXXXX, CH_PIPE, XXXXXXX, XXXXXXX,  CH_DLR, CH_ACUT,
  //|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
      XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,                        TG(4), XXXXXXX, XXXXXXX, XXXXXXX,  CH_DLR, CH_TILD,
  //|--------+--------+--------+--------+--------+--------+--------|  |--------+--------+--------+--------+--------+--------+--------|
                                          XXXXXXX, XXXXXXX, XXXXXXX,    XXXXXXX, XXXXXXX, XXXXXXX
                                      //`--------------------------'  `--------------------------'
  )
  
//      [x] = LAYOUT_split_3x6_3(
  //,-----------------------------------------------------.                    ,-----------------------------------------------------.
//      XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,                      XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
  //|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
//      XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,                      XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
  //|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
//      XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,                      XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
  //|--------+--------+--------+--------+--------+--------+--------|  |--------+--------+--------+--------+--------+--------+--------|
//                                          XXXXXXX, XXXXXXX, XXXXXXX,    XXXXXXX, XXXXXXX, XXXXXXX
                                      //`--------------------------'  `--------------------------'
//  )
};

// Tap Dance stuff ----------------------->
// Determine the current tap dance state
td_state_t cur_dance(qk_tap_dance_state_t *state) {
    if (state->count == 1) {
        if (!state->pressed) return TD_SINGLE_TAP;
        else return TD_SINGLE_HOLD;
    }
    else return TD_UNKNOWN;
}

// Initialize tap structure associated with example tap dance key
static td_tap_t ql_tap_state = {
    .is_press_action = true,
    .state = TD_NONE
};

// Functions that control what our tap dance key does
void ql_finished(qk_tap_dance_state_t *state, void *user_data) {
    ql_tap_state.state = cur_dance(state);
    switch (ql_tap_state.state) {
        case TD_SINGLE_TAP:
            set_oneshot_layer(L_OSL, ONESHOT_START);
            clear_oneshot_layer_state(ONESHOT_PRESSED);
            break;
        case TD_SINGLE_HOLD:
            layer_on(L_LOWER);
            break;
        default:
            break;
    }
}

void ql_reset(qk_tap_dance_state_t *state, void *user_data) {
    // If the key was held down and now is released then switch off the layer
    switch (ql_tap_state.state) {
    	case TD_SINGLE_TAP:
    		break;
	    case TD_SINGLE_HOLD:
	    	layer_off(L_LOWER);
	    	break;
	    default:
	    	break;
    ql_tap_state.state = TD_NONE;
   
  }
}

// Associate our tap dance key with its functionality
qk_tap_dance_action_t tap_dance_actions[] = {
    [TD_1] = ACTION_TAP_DANCE_FN_ADVANCED(NULL, ql_finished, ql_reset),
    [TD_2] = ACTION_TAP_DANCE_DOUBLE(KC_LALT, KC_RALT),
    [FN] = ACTION_TAP_DANCE_DOUBLE(KC_Y, KC_G),
    [ESC] = ACTION_TAP_DANCE_DOUBLE(KC_TAB, KC_ESC)
};
//<---------- Tap Dance stuff

#ifdef OLED_ENABLE
oled_rotation_t oled_init_user(oled_rotation_t rotation) {
  if (!is_keyboard_master()) {
    return OLED_ROTATION_180;  // flips the display 180 degrees if offhand
  }
  return rotation;
}


void oled_render_layer_state(void) {
    oled_write_P(PSTR("Layer: "), false);
    switch (get_highest_layer(layer_state)) {
        case L_MAIN:
            oled_write_ln_P(PSTR("Main"), false);
            break;
        case L_LOWER:
            oled_write_ln_P(PSTR("Lower"), false);
            break;
        case L_RAISE:
            oled_write_ln_P(PSTR("Raise"), false);
            break;
        case L_MOUSE:
            oled_write_ln_P(PSTR("Mouse"), false);
            break;
        case L_GAMING:
            oled_write_ln_P(PSTR("Gaming"), false);
            break;
        case L_OSL:
            oled_write_ln_P(PSTR("OSL"), false);
            break;
    }
}


char keylog_str[24] = {};

const char code_to_name[60] = {
    ' ', ' ', ' ', ' ', 'a', 'b', 'c', 'd', 'e', 'f',
    'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p',
    'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
    '1', '2', '3', '4', '5', '6', '7', '8', '9', '0',
    'R', 'E', 'B', 'T', '_', '-', '=', '[', ']', '\\',
    '#', ';', '\'', '`', ',', '.', '/', ' ', ' ', ' '};

void set_keylog(uint16_t keycode, keyrecord_t *record) {
  char name = ' ';
    if ((keycode >= QK_MOD_TAP && keycode <= QK_MOD_TAP_MAX) ||
        (keycode >= QK_LAYER_TAP && keycode <= QK_LAYER_TAP_MAX)) { keycode = keycode & 0xFF; }
  if (keycode < 60) {
    name = code_to_name[keycode];
  }

  // update keylog
  snprintf(keylog_str, sizeof(keylog_str), "%dx%d, k%2d : %c",
           record->event.key.row, record->event.key.col,
           keycode, name);
}

void oled_render_keylog(void) {
	oled_write("\n", false);
    oled_write(keylog_str, false);
}

void render_bootmagic_status(bool status) {
    /* Show Ctrl-Gui Swap options */
    static const char PROGMEM logo[][2][3] = {
        {{0x97, 0x98, 0}, {0xb7, 0xb8, 0}},
        {{0x95, 0x96, 0}, {0xb5, 0xb6, 0}},
    };
    if (status) {
        oled_write_ln_P(logo[0][0], false);
        oled_write_ln_P(logo[0][1], false);
    } else {
        oled_write_ln_P(logo[1][0], false);
        oled_write_ln_P(logo[1][1], false);
    }
}


bool oled_task_user(void) {
    if (is_keyboard_master()) {
        oled_render_layer_state();
        oled_render_keylog();
    }
    return false;
}

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
  if (record->event.pressed) {
    set_keylog(keycode, record);
  }
  return true;
}
#endif // OLED_ENABLE
