From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  3 Nov 2020 12:38:20 +0100
Subject: [LTP] [PATCH v3 1/2] lib: Add generic boolean expression parser and
 eval
In-Reply-To: <20201103113821.6820-1-chrubis@suse.cz>
References: <20201103113821.6820-1-chrubis@suse.cz>
Message-ID: <20201103113821.6820-2-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add a simple and generic boolean expression parser and evaluator. This
is a first step in order to implement more complex kconfig expressions,
but since we are likely to reuse the parser for other purposes in the
future it's implemented as a generic boolean parser.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---

v3:
   - now we run tokenizer twice and count number of tokens in the first
     pass then allocate all the tokens in one malloc() which simplifies
     the code again a bit
   - sligtly better formatting for error messages

 include/tst_bool_expr.h          |  86 +++++++
 lib/newlib_tests/.gitignore      |   1 +
 lib/newlib_tests/tst_bool_expr.c | 128 ++++++++++
 lib/tst_bool_expr.c              | 411 +++++++++++++++++++++++++++++++
 4 files changed, 626 insertions(+)
 create mode 100644 include/tst_bool_expr.h
 create mode 100644 lib/newlib_tests/tst_bool_expr.c
 create mode 100644 lib/tst_bool_expr.c

diff --git a/include/tst_bool_expr.h b/include/tst_bool_expr.h
new file mode 100644
index 000000000..0e2fcc2e7
--- /dev/null
+++ b/include/tst_bool_expr.h
@@ -0,0 +1,86 @@
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
+struct tst_expr_tok {
+	enum tst_op op;
+	const char *tok;
+	size_t tok_len;
+	struct tst_expr_tok *next;
+	const void *priv;
+};
+
+struct tst_expr {
+	struct tst_expr_tok *expr;
+	struct tst_expr_tok *buf;
+};
+
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
+                       int (*map)(struct tst_expr_tok *var));
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
index 000000000..f9bb1780d
--- /dev/null
+++ b/lib/newlib_tests/tst_bool_expr.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2017 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*
+ * Basic unit test for the bolean expression parser and evaluator.
+ */
+
+#include <string.h>
+#include <stdio.h>
+#include "tst_test.h"
+#include "tst_bool_expr.h"
+
+static int a, b, c;
+
+static int map(struct tst_expr_tok *var)
+{
+	if (!strncmp(var->tok, "A", var->tok_len))
+		return a;
+
+	if (!strncmp(var->tok, "B", var->tok_len))
+		return b;
+
+	if (!strncmp(var->tok, "C", var->tok_len))
+		return c;
+
+	if (!strncmp(var->tok, "True", var->tok_len))
+		return 1;
+
+	if (!strncmp(var->tok, "False", var->tok_len))
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
+	do_eval_test("A & B | C", 1, 1, 0, 1);
+	do_eval_test("((((A)))&(B))", 1, 1, 0, 1);
+	do_eval_test("   A  \t", 0, 0, 0, 0);
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
index 000000000..e4cab1474
--- /dev/null
+++ b/lib/tst_bool_expr.c
@@ -0,0 +1,411 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Cyril Hrubis <chrubis@suse.cz>
+ */
+/*
+ * Boolean expression is evaluated in three steps.
+ *
+ * First of all the string containing the expression is tokenized. The
+ * tokenizer runs twice and we only count number of tokens in the first pass in
+ * order to simplify the memory allocation.
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
+static int char_to_op(char c)
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
+		return TST_OP_VAR;
+	}
+}
+
+static int new_tok(struct tst_expr_tok **last, const char *tok, size_t tok_len)
+{
+	if (!tok_len)
+		return 0;
+
+	if (!(*last))
+		return 1;
+
+	(*last)->tok = tok;
+	(*last)->tok_len = tok_len;
+	(*last)->op = char_to_op(tok[0]);
+	(*last)++;
+
+	return 1;
+}
+
+static unsigned int tokenize(const char *expr, struct tst_expr *ret)
+{
+	size_t i, j;
+	unsigned int token_cnt = 0;
+	struct tst_expr_tok *last = ret ? ret->buf : NULL;
+
+	for (j = i = 0; expr[i]; i++) {
+		switch (expr[i]) {
+		case '(':
+		case ')':
+		case '!':
+		case '&':
+		case '|':
+			token_cnt += new_tok(&last, &expr[j], i - j);
+			token_cnt += new_tok(&last, &expr[i], 1);
+			j = i+1;
+		break;
+		case '\t':
+		case ' ':
+			token_cnt += new_tok(&last, &expr[j], i - j);
+			j = i+1;
+		break;
+		default:
+		break;
+		}
+	}
+
+	token_cnt += new_tok(&last, &expr[j], i - j);
+
+	return token_cnt;
+}
+
+void tst_bool_expr_print(FILE *f, struct tst_expr *expr)
+{
+	struct tst_expr_tok *i;
+	size_t j;
+
+	for (i = expr->expr; i; i = i->next) {
+		for (j = 0; j < i->tok_len; j++)
+			putc(i->tok[j], f);
+
+		if (i->next)
+			putc(' ', f);
+	}
+}
+
+static void print_spaces(FILE *f, unsigned int spaces)
+{
+	while (spaces--)
+		putc(' ', f);
+}
+
+static void tst_bool_expr_err(FILE *f, struct tst_expr *expr, unsigned int cnt)
+{
+	unsigned int i, spaces, err_len;
+	const char *err;
+
+	fprintf(f, "%s", expr->expr->tok);
+	fprintf(f, "\n");
+
+	for (i = 0; i < cnt; i++) {
+		if (expr->expr[i].priv)
+			break;
+	}
+
+	spaces = expr->expr[i].tok - expr->expr[0].tok;
+	err = expr->expr[i].priv;
+	err_len = strlen(err);
+
+	print_spaces(f, spaces);
+
+	fprintf(f, "^\n");
+
+	if (err_len < spaces)
+		print_spaces(f, spaces - err_len + 1);
+
+	fprintf(f, "%s\n", err);
+}
+
+static inline void stack_push(struct tst_expr_tok *stack[], unsigned int *op_stack_pos,
+                              struct tst_expr_tok *op)
+{
+	stack[(*op_stack_pos)++] = op;
+}
+
+static inline int stack_empty(unsigned int op_stack_pos)
+{
+	return op_stack_pos == 0;
+}
+
+static inline struct tst_expr_tok *stack_pop(struct tst_expr_tok *stack[],
+                                             unsigned int *op_stack_pos)
+{
+	if (stack_empty(*op_stack_pos))
+		return NULL;
+
+	return stack[--(*op_stack_pos)];
+}
+
+#define TST_OP_NONE -1
+
+static inline int stack_peek_op(struct tst_expr_tok *stack[],
+                                unsigned int op_stack_pos)
+{
+	if (stack_empty(op_stack_pos))
+		return TST_OP_NONE;
+
+	return stack[op_stack_pos - 1]->op;
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
+	case TST_OP_NONE:
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
+/*
+ * Note that we avoid modifying the list until the end so that the caller can
+ * free memory correctly, which is the reason we have a stack for parentesis
+ * that are just freed at the end.
+ */
+static int shunting_yard(struct tst_expr *expr, unsigned int cnt)
+{
+	struct tst_expr_tok *op_stack[cnt];
+	unsigned int op_stack_pos = 0;
+	struct tst_expr_tok *out[cnt + 1];
+	unsigned int out_pos = 0;
+	struct tst_expr_tok *i;
+	unsigned int j;
+	int prev_op = TST_OP_NONE;
+
+	for (i = expr->expr; i < &(expr->expr[cnt]); i++) {
+		switch (i->op) {
+		case TST_OP_VAR:
+			if (check_one(prev_op)) {
+				i->priv = "Expected operation";
+				goto err;
+			}
+
+			stack_push(out, &out_pos, i);
+
+			while (stack_peek_op(op_stack, op_stack_pos) == TST_OP_NOT)
+				stack_push(out, &out_pos, stack_pop(op_stack, &op_stack_pos));
+		break;
+		case TST_OP_LPAR:
+			if (check_one(prev_op)) {
+				i->priv = "Expected operation";
+				goto err;
+			}
+
+			stack_push(op_stack, &op_stack_pos, i);
+		break;
+		case TST_OP_RPAR:
+			if (!check_two(prev_op)) {
+				i->priv = "Expected variable or )";
+				goto err;
+			}
+
+			/* pop everything till ( */
+			for (;;) {
+				struct tst_expr_tok *op = stack_pop(op_stack, &op_stack_pos);
+
+				if (!op) {
+					i->priv = "Missing (";
+					goto err;
+				}
+
+				if (op->op == TST_OP_LPAR)
+					break;
+
+				stack_push(out, &out_pos, op);
+			}
+
+			while (stack_peek_op(op_stack, op_stack_pos) == TST_OP_NOT)
+				stack_push(out, &out_pos, stack_pop(op_stack, &op_stack_pos));
+		break;
+		case TST_OP_NOT:
+			if (check_one(prev_op)) {
+				i->priv = "Expected operation";
+				goto err;
+			}
+			stack_push(op_stack, &op_stack_pos, i);
+		break;
+		case TST_OP_AND:
+		case TST_OP_OR:
+			if (!check_two(prev_op)) {
+				i->priv = "Expected variable or (";
+				goto err;
+			}
+
+			/*
+			 * There can be at most one binary op on the stack
+			 * since we pop the one present on the stack before we
+			 * attempt to push new one they never accumulate.
+			 */
+			switch (stack_peek_op(op_stack, op_stack_pos)) {
+			case TST_OP_AND:
+			case TST_OP_OR:
+				stack_push(out, &out_pos, stack_pop(op_stack, &op_stack_pos));
+			break;
+			}
+
+			stack_push(op_stack, &op_stack_pos, i);
+		break;
+		}
+
+		prev_op = i->op;
+	}
+
+	if (!check_two(expr->buf[cnt-1].op)) {
+		expr->buf[cnt-1].priv = "Unfinished expression";
+		goto err;
+	}
+
+	/* pop remaining operations */
+	while ((i = stack_pop(op_stack, &op_stack_pos))) {
+		if (i->op == TST_OP_LPAR) {
+			i->priv = "Missing )";
+			goto err;
+		}
+
+		stack_push(out, &out_pos, i);
+	}
+
+	/* construct the list */
+	out[out_pos] = NULL;
+
+	for (j = 0; j < out_pos; j++)
+		out[j]->next = out[j + 1];
+
+	expr->expr = out[0];
+
+	return 0;
+err:
+	return 1;
+}
+
+struct tst_expr *tst_bool_expr_parse(const char *expr)
+{
+	struct tst_expr *ret;
+	struct tst_expr_tok *tok;
+	unsigned int tok_cnt = tokenize(expr, NULL);
+
+	if (!tok_cnt)
+		return NULL;
+
+	ret = malloc(sizeof(struct tst_expr));
+	tok = malloc(sizeof(struct tst_expr_tok) * tok_cnt);
+	if (!ret || !tok) {
+		free(ret);
+		free(tok);
+		return NULL;
+	}
+
+	ret->expr = ret->buf = tok;
+	tokenize(expr, ret);
+
+	if (shunting_yard(ret, tok_cnt)) {
+		tst_bool_expr_err(stderr, ret, tok_cnt);
+		tst_bool_expr_free(ret);
+		return NULL;
+	}
+
+	return ret;
+}
+
+#define MAX_STACK 16
+
+int tst_bool_expr_eval(struct tst_expr *expr,
+                       int (*map)(struct tst_expr_tok *var))
+{
+	struct tst_expr_tok *i;
+	int stack[MAX_STACK];
+	int pos = -1;
+
+	for (i = expr->expr; i; i = i->next) {
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
+	free(expr->buf);
+	free(expr);
+}
-- 
2.26.2

