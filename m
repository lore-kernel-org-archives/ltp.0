From: Alex Henrie <alexh@vpitech.com>
Date: Thu,  9 Sep 2021 10:51:10 -0600
Subject: [LTP] [PATCH linux rebase] ima: add gid support
Message-ID: <20210909165111.51038-1-alexh@vpitech.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Curtis Veit <veit@vpieng.com>

IMA currently supports the concept of rules based on uid where the rule
is based on the uid of the file owner or the uid of the user accessing
the file. It is useful to have similar rules based on gid. This patch
provides that ability.

Signed-off-by: Curtis Veit <veit@vpieng.com>
Co-developed-by: Alex Henrie <alexh@vpitech.com>
Signed-off-by: Alex Henrie <alexh@vpitech.com>
---
This is the patch that Curtis sent in 2015,[1] rebased and with support
for effective GID and the new greater-than and less-than operators.
Moreover, the policy_opt enum is now in the same order as the
policy_tokens array, which I'm guessing is the bug that prevented the
patch from being accepted before.

[1] https://sourceforge.net/p/linux-ima/mailman/message/34210250/
---
 Documentation/ABI/testing/ima_policy |   5 +-
 security/integrity/ima/ima_policy.c  | 197 +++++++++++++++++++++++----
 2 files changed, 174 insertions(+), 28 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index 5c2798534950..f8e5b5598548 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -23,7 +23,7 @@ Description:
 			  audit | hash | dont_hash
 		  condition:= base | lsm  [option]
 			base:	[[func=] [mask=] [fsmagic=] [fsuuid=] [uid=]
-				[euid=] [fowner=] [fsname=]]
+				[euid=] [gid=] [egid=] [fowner=] [fgroup=] [fsname=]]
 			lsm:	[[subj_user=] [subj_role=] [subj_type=]
 				 [obj_user=] [obj_role=] [obj_type=]]
 			option:	[[appraise_type=]] [template=] [permit_directio]
@@ -40,7 +40,10 @@ Description:
 			fsuuid:= file system UUID (e.g 8bcbe394-4f13-4144-be8e-5aa9ea2ce2f6)
 			uid:= decimal value
 			euid:= decimal value
+			gid:= decimal value
+			egid:= decimal value
 			fowner:= decimal value
+			fgroup:= decimal value
 		  lsm:  are LSM specific
 		  option:
 			appraise_type:= [imasig] [imasig|modsig]
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 87b9b71cb820..0f2287699f85 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -36,6 +36,9 @@
 #define IMA_KEYRINGS	0x0400
 #define IMA_LABEL	0x0800
 #define IMA_VALIDATE_ALGOS	0x1000
+#define IMA_GID		0x2000
+#define IMA_EGID	0x4000
+#define IMA_FGROUP	0x8000
 
 #define UNKNOWN		0
 #define MEASURE		0x0001	/* same as IMA_MEASURE */
@@ -78,9 +81,13 @@ struct ima_rule_entry {
 	unsigned long fsmagic;
 	uuid_t fsuuid;
 	kuid_t uid;
+	kgid_t gid;
 	kuid_t fowner;
+	kgid_t fgroup;
 	bool (*uid_op)(kuid_t, kuid_t);    /* Handlers for operators       */
+	bool (*gid_op)(kgid_t, kgid_t);
 	bool (*fowner_op)(kuid_t, kuid_t); /* uid_eq(), uid_gt(), uid_lt() */
+	bool (*fgroup_op)(kgid_t, kgid_t); /* gid_eq(), gid_gt(), gid_lt() */
 	int pcr;
 	unsigned int allowed_algos; /* bitfield of allowed hash algorithms */
 	struct {
@@ -104,7 +111,8 @@ static_assert(
 
 /*
  * Without LSM specific knowledge, the default policy can only be
- * written in terms of .action, .func, .mask, .fsmagic, .uid, and .fowner
+ * written in terms of .action, .func, .mask, .fsmagic, .uid, .gid,
+ * .fowner, and .fgroup
  */
 
 /*
@@ -582,10 +590,23 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 		} else if (!rule->uid_op(cred->euid, rule->uid))
 			return false;
 	}
-
+	if ((rule->flags & IMA_GID) && !rule->gid_op(rule->gid, cred->gid))
+		return false;
+	if (rule->flags & IMA_EGID) {
+		if (has_capability_noaudit(current, CAP_SETGID)) {
+			if (!rule->gid_op(cred->egid, rule->gid)
+			    && !rule->gid_op(cred->sgid, rule->gid)
+			    && !rule->gid_op(cred->gid, rule->gid))
+				return false;
+		} else if (!rule->gid_op(cred->egid, rule->gid))
+			return false;
+	}
 	if ((rule->flags & IMA_FOWNER) &&
 	    !rule->fowner_op(i_uid_into_mnt(mnt_userns, inode), rule->fowner))
 		return false;
+	if ((rule->flags & IMA_FGROUP) &&
+	    !rule->fgroup_op(i_gid_into_mnt(mnt_userns, inode), rule->fgroup))
+		return false;
 	for (i = 0; i < MAX_LSM_RULES; i++) {
 		int rc = 0;
 		u32 osid;
@@ -987,16 +1008,19 @@ void ima_update_policy(void)
 }
 
 /* Keep the enumeration in sync with the policy_tokens! */
-enum {
+enum policy_opt {
 	Opt_measure, Opt_dont_measure,
 	Opt_appraise, Opt_dont_appraise,
 	Opt_audit, Opt_hash, Opt_dont_hash,
 	Opt_obj_user, Opt_obj_role, Opt_obj_type,
 	Opt_subj_user, Opt_subj_role, Opt_subj_type,
-	Opt_func, Opt_mask, Opt_fsmagic, Opt_fsname,
-	Opt_fsuuid, Opt_uid_eq, Opt_euid_eq, Opt_fowner_eq,
-	Opt_uid_gt, Opt_euid_gt, Opt_fowner_gt,
-	Opt_uid_lt, Opt_euid_lt, Opt_fowner_lt,
+	Opt_func, Opt_mask, Opt_fsmagic, Opt_fsname, Opt_fsuuid,
+	Opt_uid_eq, Opt_euid_eq, Opt_gid_eq, Opt_egid_eq,
+	Opt_fowner_eq, Opt_fgroup_eq,
+	Opt_uid_gt, Opt_euid_gt, Opt_gid_gt, Opt_egid_gt,
+	Opt_fowner_gt, Opt_fgroup_gt,
+	Opt_uid_lt, Opt_euid_lt, Opt_gid_lt, Opt_egid_lt,
+	Opt_fowner_lt, Opt_fgroup_lt,
 	Opt_appraise_type, Opt_appraise_flag, Opt_appraise_algos,
 	Opt_permit_directio, Opt_pcr, Opt_template, Opt_keyrings,
 	Opt_label, Opt_err
@@ -1023,13 +1047,22 @@ static const match_table_t policy_tokens = {
 	{Opt_fsuuid, "fsuuid=%s"},
 	{Opt_uid_eq, "uid=%s"},
 	{Opt_euid_eq, "euid=%s"},
+	{Opt_gid_eq, "gid=%s"},
+	{Opt_egid_eq, "egid=%s"},
 	{Opt_fowner_eq, "fowner=%s"},
+	{Opt_fgroup_eq, "fgroup=%s"},
 	{Opt_uid_gt, "uid>%s"},
 	{Opt_euid_gt, "euid>%s"},
+	{Opt_gid_gt, "gid>%s"},
+	{Opt_egid_gt, "egid>%s"},
 	{Opt_fowner_gt, "fowner>%s"},
+	{Opt_fgroup_gt, "fgroup>%s"},
 	{Opt_uid_lt, "uid<%s"},
 	{Opt_euid_lt, "euid<%s"},
+	{Opt_gid_lt, "gid<%s"},
+	{Opt_egid_lt, "egid<%s"},
 	{Opt_fowner_lt, "fowner<%s"},
+	{Opt_fgroup_lt, "fgroup<%s"},
 	{Opt_appraise_type, "appraise_type=%s"},
 	{Opt_appraise_flag, "appraise_flag=%s"},
 	{Opt_appraise_algos, "appraise_algos=%s"},
@@ -1073,22 +1106,36 @@ static int ima_lsm_rule_init(struct ima_rule_entry *entry,
 }
 
 static void ima_log_string_op(struct audit_buffer *ab, char *key, char *value,
-			      bool (*rule_operator)(kuid_t, kuid_t))
+			      enum policy_opt rule_operator)
 {
 	if (!ab)
 		return;
 
-	if (rule_operator == &uid_gt)
+	switch (rule_operator) {
+	case Opt_uid_gt:
+	case Opt_euid_gt:
+	case Opt_gid_gt:
+	case Opt_egid_gt:
+	case Opt_fowner_gt:
+	case Opt_fgroup_gt:
 		audit_log_format(ab, "%s>", key);
-	else if (rule_operator == &uid_lt)
+		break;
+	case Opt_uid_lt:
+	case Opt_euid_lt:
+	case Opt_gid_lt:
+	case Opt_egid_lt:
+	case Opt_fowner_lt:
+	case Opt_fgroup_lt:
 		audit_log_format(ab, "%s<", key);
-	else
+		break;
+	default:
 		audit_log_format(ab, "%s=", key);
+	}
 	audit_log_format(ab, "%s ", value);
 }
 static void ima_log_string(struct audit_buffer *ab, char *key, char *value)
 {
-	ima_log_string_op(ab, key, value, NULL);
+	ima_log_string_op(ab, key, value, Opt_err);
 }
 
 /*
@@ -1163,7 +1210,8 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 		if (entry->flags & ~(IMA_FUNC | IMA_MASK | IMA_FSMAGIC |
 				     IMA_UID | IMA_FOWNER | IMA_FSUUID |
 				     IMA_INMASK | IMA_EUID | IMA_PCR |
-				     IMA_FSNAME | IMA_DIGSIG_REQUIRED |
+				     IMA_FSNAME | IMA_GID | IMA_EGID |
+				     IMA_FGROUP | IMA_DIGSIG_REQUIRED |
 				     IMA_PERMIT_DIRECTIO | IMA_VALIDATE_ALGOS))
 			return false;
 
@@ -1174,7 +1222,8 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 		if (entry->flags & ~(IMA_FUNC | IMA_MASK | IMA_FSMAGIC |
 				     IMA_UID | IMA_FOWNER | IMA_FSUUID |
 				     IMA_INMASK | IMA_EUID | IMA_PCR |
-				     IMA_FSNAME | IMA_DIGSIG_REQUIRED |
+				     IMA_FSNAME | IMA_GID | IMA_EGID |
+				     IMA_FGROUP | IMA_DIGSIG_REQUIRED |
 				     IMA_PERMIT_DIRECTIO | IMA_MODSIG_ALLOWED |
 				     IMA_CHECK_BLACKLIST | IMA_VALIDATE_ALGOS))
 			return false;
@@ -1186,7 +1235,8 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 
 		if (entry->flags & ~(IMA_FUNC | IMA_FSMAGIC | IMA_UID |
 				     IMA_FOWNER | IMA_FSUUID | IMA_EUID |
-				     IMA_PCR | IMA_FSNAME))
+				     IMA_PCR | IMA_FSNAME | IMA_GID | IMA_EGID |
+				     IMA_FGROUP))
 			return false;
 
 		break;
@@ -1195,7 +1245,7 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 			return false;
 
 		if (entry->flags & ~(IMA_FUNC | IMA_UID | IMA_PCR |
-				     IMA_KEYRINGS))
+				     IMA_KEYRINGS | IMA_GID))
 			return false;
 
 		if (ima_rule_contains_lsm_cond(entry))
@@ -1207,7 +1257,7 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 			return false;
 
 		if (entry->flags & ~(IMA_FUNC | IMA_UID | IMA_PCR |
-				     IMA_LABEL))
+				     IMA_LABEL | IMA_GID))
 			return false;
 
 		if (ima_rule_contains_lsm_cond(entry))
@@ -1276,7 +1326,7 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 	struct audit_buffer *ab;
 	char *from;
 	char *p;
-	bool uid_token;
+	bool eid_token;
 	struct ima_template_desc *template_desc;
 	int result = 0;
 
@@ -1284,9 +1334,13 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 				       AUDIT_INTEGRITY_POLICY_RULE);
 
 	entry->uid = INVALID_UID;
+	entry->gid = INVALID_GID;
 	entry->fowner = INVALID_UID;
+	entry->fgroup = INVALID_GID;
 	entry->uid_op = &uid_eq;
+	entry->gid_op = &gid_eq;
 	entry->fowner_op = &uid_eq;
+	entry->fgroup_op = &gid_eq;
 	entry->action = UNKNOWN;
 	while ((p = strsep(&rule, " \t")) != NULL) {
 		substring_t args[MAX_OPT_ARGS];
@@ -1504,12 +1558,12 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 			fallthrough;
 		case Opt_uid_eq:
 		case Opt_euid_eq:
-			uid_token = (token == Opt_uid_eq) ||
-				    (token == Opt_uid_gt) ||
-				    (token == Opt_uid_lt);
+			eid_token = (token == Opt_euid_eq) ||
+				    (token == Opt_euid_gt) ||
+				    (token == Opt_euid_lt);
 
-			ima_log_string_op(ab, uid_token ? "uid" : "euid",
-					  args[0].from, entry->uid_op);
+			ima_log_string_op(ab, eid_token ? "euid" : "uid",
+					  args[0].from, token);
 
 			if (uid_valid(entry->uid)) {
 				result = -EINVAL;
@@ -1524,8 +1578,41 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 				    (uid_t)lnum != lnum)
 					result = -EINVAL;
 				else
-					entry->flags |= uid_token
-					    ? IMA_UID : IMA_EUID;
+					entry->flags |= eid_token
+					    ? IMA_EUID : IMA_UID;
+			}
+			break;
+		case Opt_gid_gt:
+		case Opt_egid_gt:
+			entry->gid_op = &gid_gt;
+			fallthrough;
+		case Opt_gid_lt:
+		case Opt_egid_lt:
+			if ((token == Opt_gid_lt) || (token == Opt_egid_lt))
+				entry->gid_op = &gid_lt;
+			fallthrough;
+		case Opt_gid_eq:
+		case Opt_egid_eq:
+			eid_token = (token == Opt_egid_eq) ||
+				    (token == Opt_egid_gt) ||
+				    (token == Opt_egid_lt);
+
+			ima_log_string_op(ab, eid_token ? "egid" : "gid",
+					  args[0].from, token);
+
+			if (gid_valid(entry->gid)) {
+				result = -EINVAL;
+				break;
+			}
+
+			result = kstrtoul(args[0].from, 10, &lnum);
+			if (!result) {
+				entry->gid = make_kgid(current_user_ns(), (gid_t)lnum);
+				if (!gid_valid(entry->gid) || (((gid_t)lnum) != lnum))
+					result = -EINVAL;
+				else
+					entry->flags |= eid_token
+					    ? IMA_EGID : IMA_GID;
 			}
 			break;
 		case Opt_fowner_gt:
@@ -1536,8 +1623,7 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 				entry->fowner_op = &uid_lt;
 			fallthrough;
 		case Opt_fowner_eq:
-			ima_log_string_op(ab, "fowner", args[0].from,
-					  entry->fowner_op);
+			ima_log_string_op(ab, "fowner", args[0].from, token);
 
 			if (uid_valid(entry->fowner)) {
 				result = -EINVAL;
@@ -1553,6 +1639,30 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 					entry->flags |= IMA_FOWNER;
 			}
 			break;
+		case Opt_fgroup_gt:
+			entry->fgroup_op = &gid_gt;
+			fallthrough;
+		case Opt_fgroup_lt:
+			if (token == Opt_fgroup_lt)
+				entry->fgroup_op = &gid_lt;
+			fallthrough;
+		case Opt_fgroup_eq:
+			ima_log_string_op(ab, "fgroup", args[0].from, token);
+
+			if (gid_valid(entry->fgroup)) {
+				result = -EINVAL;
+				break;
+			}
+
+			result = kstrtoul(args[0].from, 10, &lnum);
+			if (!result) {
+				entry->fgroup = make_kgid(current_user_ns(), (gid_t)lnum);
+				if (!gid_valid(entry->fgroup) || (((gid_t)lnum) != lnum))
+					result = -EINVAL;
+				else
+					entry->flags |= IMA_FGROUP;
+			}
+			break;
 		case Opt_obj_user:
 			ima_log_string(ab, "obj_user", args[0].from);
 			result = ima_lsm_rule_init(entry, args,
@@ -1936,6 +2046,28 @@ int ima_policy_show(struct seq_file *m, void *v)
 		seq_puts(m, " ");
 	}
 
+	if (entry->flags & IMA_GID) {
+		snprintf(tbuf, sizeof(tbuf), "%d", __kgid_val(entry->gid));
+		if (entry->gid_op == &gid_gt)
+			seq_printf(m, pt(Opt_gid_gt), tbuf);
+		else if (entry->gid_op == &gid_lt)
+			seq_printf(m, pt(Opt_gid_lt), tbuf);
+		else
+			seq_printf(m, pt(Opt_gid_eq), tbuf);
+		seq_puts(m, " ");
+	}
+
+	if (entry->flags & IMA_EGID) {
+		snprintf(tbuf, sizeof(tbuf), "%d", __kgid_val(entry->gid));
+		if (entry->gid_op == &gid_gt)
+			seq_printf(m, pt(Opt_egid_gt), tbuf);
+		else if (entry->gid_op == &gid_lt)
+			seq_printf(m, pt(Opt_egid_lt), tbuf);
+		else
+			seq_printf(m, pt(Opt_egid_eq), tbuf);
+		seq_puts(m, " ");
+	}
+
 	if (entry->flags & IMA_FOWNER) {
 		snprintf(tbuf, sizeof(tbuf), "%d", __kuid_val(entry->fowner));
 		if (entry->fowner_op == &uid_gt)
@@ -1947,6 +2079,17 @@ int ima_policy_show(struct seq_file *m, void *v)
 		seq_puts(m, " ");
 	}
 
+	if (entry->flags & IMA_FGROUP) {
+		snprintf(tbuf, sizeof(tbuf), "%d", __kgid_val(entry->fgroup));
+		if (entry->fgroup_op == &gid_gt)
+			seq_printf(m, pt(Opt_fgroup_gt), tbuf);
+		else if (entry->fgroup_op == &gid_lt)
+			seq_printf(m, pt(Opt_fgroup_lt), tbuf);
+		else
+			seq_printf(m, pt(Opt_fgroup_eq), tbuf);
+		seq_puts(m, " ");
+	}
+
 	if (entry->flags & IMA_VALIDATE_ALGOS) {
 		seq_puts(m, "appraise_algos=");
 		ima_policy_show_appraise_algos(m, entry->allowed_algos);
-- 
2.33.0

