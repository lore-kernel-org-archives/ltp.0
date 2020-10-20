From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 20 Oct 2020 12:09:09 +0200
Subject: [LTP] [PATCH 2/3] lib: Add generic boolean expression parser and
 eval
In-Reply-To: <20201020100910.10828-1-chrubis@suse.cz>
References: <20201020100910.10828-1-chrubis@suse.cz>
Message-ID: <20201020100910.10828-3-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add a simple and generic boolean expression parser and evaluator. This
is a second step in order to implement more complex kconfig expressions,
but since we are likely to reuse the parser for other purposes in the
future it's implemented as a generic boolean parser.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_bool_expr.h          |  80 +++++
 lib/newlib_tests/.gitignore      |   1 +
 lib/newlib_tests/tst_bool_expr.c | 127 ++++++++
 lib/tst_bool_expr.c              | 504 +++++++++++++++++++++++++++++++
 4 files changed, 712 insertions(+)
 create mode 100644 include/tst_bool_expr.h
 create mode 100644 lib/newlib_tests/tst_bool_expr.c
 create mode 100644 lib/tst_bool_expr.c

diff --git a/include/tst_bool_expr.h b/include/tst_bool_expr.h
new file mode 100644
index 000000000..e163690ab
--- /dev/null
+++ b/include/tst_bool_expr.h
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+#ifndef TST_BOOL_EXPR_H__
+#define TST_BOOL_EXPR_H__
+
+enum tst_op {
+	TST_OP_NOT,
+	TST_OP_AND,
+	TST_OP_OR,
+	TST_OP_VAR,
+	/* Used only internally */
+	TST_OP_LPAR,
+	TST_OP_RPAR,
+};
+
+struct tst_expr {
+	enum tst_op op;
+	struct tst_expr *next;
+	char *err;
+	void *priv;
+	char val[];
+};
+
+/*
+ * Parses an boolean expression and returns a simplified RPN version.
+ *
+ * If expression is not valid the call prints error into stderr and returns
+ * NULL. On success pointer to an expression is returned which can be evaluated
+ * by the tst_bool_expr_eval() function and has to be later freed by the
+ * caller.
+ *
+ * The boolean expression can consists of:
+ *
+ * - unary negation opeartion !
+ * - two binary operations & and |
+ * - correct sequence of parentheses ()
+ * - strings that are treated as boolean variables
+ *
+ *  e.g. '(A | B) & C' or 'Variable_1 & Variable_2' are both a valid boolean
+ *  expressions.
+ *
+ *  @expr String containing a boolean expression to be parsed.
+ *  @return Pointer to an RPN expression.
+ */
+struct tst_expr *tst_bool_expr_parse(const char *expr);
+
+/*
+ * Prints an string representation of the expression into a FILE.
+ *
+ * @param A FILE to print to.
+ * @expr An expression to print.
+ */
+void tst_bool_expr_print(FILE *f, struct tst_expr *expr);
+
+/*
+ * Evaluates an expression given a map for variables.
+ *
+ * The call will fail if:
+ * - map function returns -1 which indicates undefined variable
+ * - the eval function runs out of stack
+ *
+ * @param expr Boolean expression in RPN.
+ * @param map Mapping function for boolean variables.
+ *
+ * @return Returns 0 or 1 if expression was evaluated correctly and -1 on error.
+ */
+int tst_bool_expr_eval(struct tst_expr *expr,
+                       int (*map)(struct tst_expr *var));
+
+/*
+ * Frees the memory allocated by the tst_bool_expr_parse().
+ *
+ * @param Boolean expression.
+ */
+void tst_bool_expr_free(struct tst_expr *expr);
+
+#endif	/* TST_BOOL_EXPR_H__ */
diff --git a/lib/newlib_tests/.gitignore b/lib/newlib_tests/.gitignore
index 44bc6526f..1e96db1da 100644
--- a/lib/newlib_tests/.gitignore
+++ b/lib/newlib_tests/.gitignore
@@ -33,3 +33,4 @@ test_exec_child
 test_kconfig
 variant
 test_guarded_buf
+tst_bool_expr
diff --git a/lib/newlib_tests/tst_bool_expr.c b/lib/newlib_tests/tst_bool_expr.c
new file mode 100644
index 000000000..5f5e618dc
--- /dev/null
+++ b/lib/newlib_tests/tst_bool_expr.c
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2017 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*
+ * Basic unit test for the tst_strstatus() function.
+ */
+
+#include <string.h>
+#include <stdio.h>
+#include "tst_test.h"
+#include "tst_bool_expr.h"
+
+static int a, b, c;
+
+static int map(struct tst_expr *var)
+{
+	if (!strcmp(var->val, "A"))
+		return a;
+
+	if (!strcmp(var->val, "B"))
+		return b;
+
+	if (!strcmp(var->val, "C"))
+		return c;
+
+	if (!strcmp(var->val, "True"))
+		return 1;
+
+	if (!strcmp(var->val, "False"))
+		return 0;
+
+	return -1;
+}
+
+static void parse_fail(const char *expr)
+{
+	struct tst_expr *res;
+
+	tst_res(TINFO, "Parsing '%s'", expr);
+
+	res = tst_bool_expr_parse(expr);
+
+	if (res) {
+		printf("In RPN: ");
+		tst_bool_expr_print(stdout, res);
+		printf("\n");
+		tst_bool_expr_free(res);
+		tst_res(TFAIL, "Expression was parsed");
+	} else {
+		tst_res(TPASS, "Parser returned an error");
+	}
+}
+
+static void do_eval_test(const char *expr_str, int set_a, int set_b, int set_c, int exp_res)
+{
+	struct tst_expr *expr;
+	int res;
+
+	a = set_a;
+	b = set_b;
+	c = set_c;
+
+	tst_res(TINFO, "'%s' A=%i B=%i C=%i == %i", expr_str, a, b, c, exp_res);
+
+	expr = tst_bool_expr_parse(expr_str);
+
+	if (!expr) {
+		tst_res(TFAIL, "Parser returned error");
+		return;
+	}
+
+	printf("In RPN: ");
+	tst_bool_expr_print(stdout, expr);
+	printf("\n");
+
+	res = tst_bool_expr_eval(expr, map);
+
+	if (res == exp_res)
+		tst_res(TPASS, "Got %i", res);
+	else
+		tst_res(TFAIL, "Got %i", res);
+
+	tst_bool_expr_free(expr);
+}
+
+static void do_test(void)
+{
+	do_eval_test("(A | B) & !!C", 0, 0, 0, 0);
+	do_eval_test("(A | B) & !!C", 1, 0, 1, 1);
+	do_eval_test("!A & B", 1, 0, 0, 0);
+	do_eval_test("!A & B", 0, 1, 0, 1);
+	do_eval_test("A & !B", 1, 0, 0, 1);
+	do_eval_test("!!A & !!B", 0, 1, 0, 0);
+	do_eval_test("!!A & !!B", 1, 1, 0, 1);
+	do_eval_test("!(A & B) & C", 1, 1, 0, 0);
+	do_eval_test("A & (B | C)", 1, 1, 0, 1);
+	do_eval_test("((((A)))&(B))", 1, 1, 0, 1);
+	do_eval_test("True | A", 0, 0, 0, 1);
+	do_eval_test("False & A", 1, 0, 0, 0);
+	do_eval_test("! Undefined", 0, 0, 0, -1);
+
+	parse_fail("A!");
+	parse_fail("A &");
+	parse_fail("A B");
+	parse_fail("A ) B");
+	parse_fail("A ( B");
+	parse_fail("A ( B )");
+	parse_fail("A |");
+	parse_fail("A ! B");
+	parse_fail("A! & B");
+	parse_fail("A & | B");
+	parse_fail("A & (B |)");
+	parse_fail("A & ( | B)");
+	parse_fail("A & B &");
+	parse_fail("((A )");
+	parse_fail("& A");
+	parse_fail("! &");
+	parse_fail(")");
+	parse_fail("| A");
+	parse_fail("");
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+};
diff --git a/lib/tst_bool_expr.c b/lib/tst_bool_expr.c
new file mode 100644
index 000000000..3cb395664
--- /dev/null
+++ b/lib/tst_bool_expr.c
@@ -0,0 +1,504 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Cyril Hrubis <chrubis@suse.cz>
+ */
+/*
+ * Boolean expression is evaluated in three steps.
+ *
+ * First of all the string containing the expression is tokenized.
+ *
+ * Secondly the the expression is transformed to a postfix (RPN) notation by
+ * the shunting yard algorithm and the correctness of the expression is checked
+ * during the transformation as well. The fact that parenthesis are matched is
+ * asserted by the shunting yard algorithm itself while the rest is checked
+ * simply by checking if the preceding token is in a set of allowed tokens.
+ * This could be thought of as a simple open-coded state machine.
+ *
+ * An expression in the RPN form can be evaluated given a variable mapping
+ * function. The evaluation ignores most of errors because invalid expression
+ * will be rejected in the second step.
+ */
+
+#include <string.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include "tst_bool_expr.h"
+
+#define MAX_TOK 1024
+
+struct tok {
+	unsigned int pos;
+	char buf[MAX_TOK];
+};
+
+static inline void tok_append(struct tok *tok, char c)
+{
+	if (tok->pos + 2 >= MAX_TOK) {
+		tok->buf[tok->pos+1] = 0;
+		fprintf(stderr, "Truncating token '%s'!", tok->buf);
+	}
+
+	tok->buf[tok->pos++] = c;
+}
+
+static inline char *tok_get(struct tok *tok)
+{
+	if (!tok->pos)
+		return NULL;
+
+	tok->buf[tok->pos] = '\0';
+
+	tok->pos = 0;
+
+	return tok->buf;
+}
+
+static struct tst_expr *new_var(const char *val)
+{
+	struct tst_expr *ret;
+
+	if (!val)
+		return NULL;
+
+	ret = malloc(sizeof(struct tst_expr) + strlen(val) + 1);
+	if (!ret)
+		return NULL;
+
+	ret->op = TST_OP_VAR;
+	ret->next = NULL;
+	ret->err = NULL;
+	strcpy(ret->val, val);
+
+	return ret;
+}
+
+enum tst_op char_to_op(char c)
+{
+	switch (c) {
+	case '(':
+		return TST_OP_LPAR;
+	case ')':
+		return TST_OP_RPAR;
+	case '&':
+		return TST_OP_AND;
+	case '|':
+		return TST_OP_OR;
+	case '!':
+		return TST_OP_NOT;
+	default:
+		return -1;
+	}
+}
+
+static struct tst_expr *new_op(char c)
+{
+	struct tst_expr *ret;
+
+	ret = malloc(sizeof(struct tst_expr));
+	if (!ret)
+		return NULL;
+
+	ret->op = char_to_op(c);
+	ret->next = NULL;
+	ret->err = NULL;
+
+	return ret;
+}
+
+struct op_list {
+	struct tst_expr *first;
+	struct tst_expr *last;
+	unsigned int cnt;
+};
+
+static void op_list_append(struct op_list *list, struct tst_expr *val)
+{
+	if (!val)
+		return;
+
+	if (!list->first)
+		list->first = val;
+
+	if (list->last)
+		list->last->next = val;
+
+	list->last = val;
+
+	list->cnt++;
+}
+
+static void tokenize(const char *expr, struct op_list *ret)
+{
+	struct tok buf = {};
+	size_t i;
+
+	for (i = 0; expr[i]; i++) {
+		switch (expr[i]) {
+		case '(':
+		case ')':
+		case '!':
+		case '&':
+		case '|':
+			op_list_append(ret, new_var(tok_get(&buf)));
+			op_list_append(ret, new_op(expr[i]));
+		break;
+		case '\t':
+		case ' ':
+			op_list_append(ret, new_var(tok_get(&buf)));
+		break;
+		default:
+			tok_append(&buf, expr[i]);
+		break;
+		}
+	}
+
+	op_list_append(ret, new_var(tok_get(&buf)));
+}
+
+void tst_bool_expr_print(FILE *f, struct tst_expr *expr)
+{
+	struct tst_expr *i;
+	int prev_op = 0;
+
+	for (i = expr; i; i = i->next) {
+		if (i->op != TST_OP_VAR && prev_op)
+			fprintf(f, " ");
+
+		switch (i->op) {
+		case TST_OP_AND:
+			fprintf(f, "&");
+		break;
+		case TST_OP_OR:
+			fprintf(f, "|");
+		break;
+		case TST_OP_NOT:
+			fprintf(f, "!");
+		break;
+		case TST_OP_LPAR:
+			fprintf(f, "(");
+		break;
+		case TST_OP_RPAR:
+			fprintf(f, ")");
+		break;
+		case TST_OP_VAR:
+			fprintf(f, " %s ", i->val);
+		break;
+		}
+
+		if (i->op == TST_OP_VAR)
+			prev_op = 0;
+		else
+			prev_op = 1;
+	}
+}
+
+static void tst_bool_expr_err(FILE *f, struct tst_expr *expr)
+{
+	struct tst_expr *i;
+	int prev_op = 0;
+	unsigned int spaces = 0;
+
+	fprintf(f, "\n");
+
+	for (i = expr; i; i = i->next) {
+		if (i->err)
+			break;
+
+		if (i->op != TST_OP_VAR && prev_op)
+			spaces++;
+
+		switch (i->op) {
+		case TST_OP_VAR:
+			spaces += 2 + strlen(i->val);
+		break;
+		default:
+			spaces++;
+		}
+
+		if (i->op == TST_OP_VAR)
+			prev_op = 0;
+		else
+			prev_op = 1;
+	}
+
+	while (spaces--)
+		putc(' ', f);
+
+	fprintf(f, "^\n");
+	fprintf(f, "%s\n", i->err);
+}
+
+static inline void stack_push(struct tst_expr *stack[], unsigned int *stack_pos,
+                              struct tst_expr *op)
+{
+	stack[(*stack_pos)++] = op;
+}
+
+static inline int stack_empty(unsigned int stack_pos)
+{
+	return stack_pos == 0;
+}
+
+static inline struct tst_expr *stack_pop(struct tst_expr *stack[],
+                                          unsigned int *stack_pos)
+{
+	if (stack_empty(*stack_pos))
+		return NULL;
+
+	return stack[--(*stack_pos)];
+}
+
+static inline enum tst_op stack_top_op(struct tst_expr *stack[],
+                                       unsigned int stack_pos)
+{
+	if (stack_empty(stack_pos))
+		return -1;
+
+	return stack[stack_pos - 1]->op;
+}
+
+/*
+ * This is a complete list of which tokens can happen before any of:
+ *  - variable
+ *  - left parentesis
+ *  - negation
+ *
+ * The -1 represents start of the expression.
+ */
+static inline int check_one(int op)
+{
+	switch (op) {
+	case TST_OP_AND:
+	case TST_OP_OR:
+	case TST_OP_NOT:
+	case -1:
+	case TST_OP_LPAR:
+		return 0;
+	default:
+		return 1;
+	}
+}
+
+/*
+ * And this checks for tokens that can happen before any of:
+ * - right parentesis
+ * - and
+ * - or
+ *
+ * This is also used to check that the last token in expression is correct one.
+ */
+static inline int check_two(int op)
+{
+	switch (op) {
+	case TST_OP_VAR:
+	case TST_OP_RPAR:
+		return 1;
+	default:
+		return 0;
+	}
+}
+
+static struct tst_expr *shunting_yard(struct op_list *list)
+{
+	struct tst_expr *stack[list->cnt];
+	unsigned int stack_pos = 0;
+	struct tst_expr *out[list->cnt + 1];
+	unsigned int out_pos = 0;
+	struct tst_expr *pars[list->cnt];
+	unsigned int pars_pos = 0;
+	struct tst_expr *i;
+	unsigned int j;
+	int prev_op = -1;
+
+	for (i = list->first; i; i = i->next) {
+		switch (i->op) {
+		case TST_OP_VAR:
+			if (check_one(prev_op) && prev_op != TST_OP_LPAR) {
+				i->err = "Expected operation";
+				goto err;
+			}
+
+			stack_push(out, &out_pos, i);
+
+			/* pop all negations */
+			while (stack_top_op(stack, stack_pos) == TST_OP_NOT)
+				stack_push(out, &out_pos, stack_pop(stack, &stack_pos));
+		break;
+		case TST_OP_LPAR:
+			if (check_one(prev_op)) {
+				i->err = "Expected operation";
+				goto err;
+			}
+
+			stack_push(stack, &stack_pos, i);
+		break;
+		case TST_OP_RPAR:
+			if (!check_two(prev_op)) {
+				i->err = "Expected variable or )";
+				goto err;
+			}
+
+			stack_push(pars, &pars_pos, i);
+
+			/* pop everything till ( */
+			for (;;) {
+				struct tst_expr *op = stack_pop(stack, &stack_pos);
+
+				if (!op) {
+					i->err = "Missing (";
+					goto err;
+				}
+
+				if (op->op == TST_OP_LPAR) {
+					stack_push(pars, &pars_pos, op);
+					break;
+				}
+
+				stack_push(out, &out_pos, op);
+			}
+
+			/* pop all negations */
+			while (stack_top_op(stack, stack_pos) == TST_OP_NOT)
+				stack_push(out, &out_pos, stack_pop(stack, &stack_pos));
+		break;
+		case TST_OP_NOT:
+			if (check_one(prev_op)) {
+				i->err = "Expected operation";
+				goto err;
+			}
+			stack_push(stack, &stack_pos, i);
+		break;
+		case TST_OP_AND:
+		case TST_OP_OR:
+			if (!check_two(prev_op)) {
+				i->err = "Expected variable or (";
+				goto err;
+			}
+
+			/* pop all binary ops */
+			for (;;) {
+				enum tst_op top_op;
+
+				if (stack_empty(stack_pos))
+					break;
+
+				top_op = stack_top_op(stack, stack_pos);
+
+				if (top_op == TST_OP_LPAR ||
+				    top_op == TST_OP_NOT)
+					break;
+
+				stack_push(out, &out_pos, stack_pop(stack, &stack_pos));
+			}
+			stack_push(stack, &stack_pos, i);
+		break;
+		}
+
+		prev_op = i->op;
+	}
+
+	if (!check_two(list->last->op)) {
+		list->last->err = "Unfinished expression";
+		goto err;
+	}
+
+	/* pop remaining operations */
+	while ((i = stack_pop(stack, &stack_pos))) {
+		if (i->op == TST_OP_LPAR) {
+			i->err = "Missing )";
+			goto err;
+		}
+
+		stack_push(out, &out_pos, i);
+	}
+
+	/* free parentesis */
+	for (j = 0; j < pars_pos; j++)
+		free(pars[j]);
+
+	/* reconstruct the list */
+	out[out_pos] = NULL;
+
+	for (j = 0; j < out_pos; j++)
+		out[j]->next = out[j + 1];
+
+	return out[0];
+err:
+	return NULL;
+}
+
+struct tst_expr *tst_bool_expr_parse(const char *expr)
+{
+	struct op_list list = {};
+	struct tst_expr *ret;
+
+	tokenize(expr, &list);
+
+	if (!list.first)
+		return NULL;
+
+	ret = shunting_yard(&list);
+
+	if (!ret) {
+		tst_bool_expr_print(stderr, list.first);
+		tst_bool_expr_err(stderr, list.first);
+		tst_bool_expr_free(list.first);
+		return NULL;
+	}
+
+	return ret;
+}
+
+#define MAX_STACK 16
+
+int tst_bool_expr_eval(struct tst_expr *expr,
+                       int (*map)(struct tst_expr *var))
+{
+	struct tst_expr *i;
+	int stack[MAX_STACK];
+	int pos = -1;
+
+	for (i = expr; i; i = i->next) {
+		switch (i->op) {
+		case TST_OP_NOT:
+			stack[pos] = !stack[pos];
+		break;
+		case TST_OP_OR:
+			stack[pos-1] = stack[pos] || stack[pos-1];
+			pos--;
+		break;
+		case TST_OP_AND:
+			stack[pos-1] = stack[pos] && stack[pos-1];
+			pos--;
+		break;
+		case TST_OP_VAR:
+			if (pos + 1 >= MAX_STACK) {
+				fprintf(stderr, "Eval out of stack!\n");
+				return -1;
+			}
+
+			stack[++pos] = map(i);
+
+			/* map reported undefined variable -> abort */
+			if (stack[pos] == -1)
+				return -1;
+		break;
+		/* does not happen */
+		default:
+		break;
+		}
+	}
+
+	return stack[0];
+}
+
+void tst_bool_expr_free(struct tst_expr *expr)
+{
+	struct tst_expr *i = expr, *tmp;
+
+	while (i) {
+		tmp = i;
+		i = i->next;
+		free(tmp);
+	}
+}
-- 
2.26.2

