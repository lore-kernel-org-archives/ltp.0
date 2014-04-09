Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gux.fnst@cn.fujitsu.com>) id 1WXiE1-00067F-72
	for ltp-list@lists.sourceforge.net; Wed, 09 Apr 2014 02:26:53 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WXiDy-0007CG-4c
	for ltp-list@lists.sourceforge.net; Wed, 09 Apr 2014 02:26:53 +0000
Message-ID: <5344AFCD.4000406@cn.fujitsu.com>
Date: Wed, 9 Apr 2014 10:26:21 +0800
From: "gux.fnst" <gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
References: <1396526450-22885-1-git-send-email-gux.fnst@cn.fujitsu.com>
	<36493213.5963741.1396605704407.JavaMail.zimbra@redhat.com>
In-Reply-To: <36493213.5963741.1396605704407.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH v2 1/2] lib/tst_path_has_mnt_flags.c: create a
 function tst_path_has_mnt_flags()
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5335955892431550764=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

--===============5335955892431550764==
Content-Type: multipart/alternative;
	boundary="------------090502030100020905010505"

--------------090502030100020905010505
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit


On 04/04/2014 06:01 PM, Jan Stancek wrote:
>
>
>
> ----- Original Message -----
>> From: "gux fnst" <gux.fnst@cn.fujitsu.com>
>> To: ltp-list@lists.sourceforge.net
>> Sent: Thursday, 3 April, 2014 2:00:44 PM
>> Subject: [LTP] [PATCH v2 1/2] lib/tst_path_has_mnt_flags.c: create a function tst_path_has_mnt_flags()
>>
>> Create a function tst_path_has_mnt_flags() for checking whether
>> a path is on a system that is mounted with specified flags.
>>
>> Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
>> ---
>>   include/test.h               |  9 ++++
>>   lib/tst_path_has_mnt_flags.c | 99
>>   ++++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 108 insertions(+)
>>   create mode 100644 lib/tst_path_has_mnt_flags.c
>>
>> diff --git a/include/test.h b/include/test.h
>> index baa3ef6..39bc5a1 100644
>> --- a/include/test.h
>> +++ b/include/test.h
>> @@ -295,6 +295,15 @@ gid_t tst_get_unused_gid(void);
>>   unsigned short tst_get_unused_port(void (cleanup_fn)(void),
>>   	unsigned short family, int type);
>>   
>> +/* lib/tst_path_has_mnt_flags.c
>> + *
>> + * Check whether a path is on a filesystem that is mounted with
>> + * specified flags.
>> + * @path: path to file
>> + * @flags: mount flags
>> + */
>> +int tst_path_has_mnt_flags(const char *path, const char *flags[]);
>> +
>>   #ifdef TST_USE_COMPAT16_SYSCALL
>>   #define TCID_BIT_SUFFIX "_16"
>>   #elif  TST_USE_NEWER64_SYSCALL
>> diff --git a/lib/tst_path_has_mnt_flags.c b/lib/tst_path_has_mnt_flags.c
>> new file mode 100644
>> index 0000000..257b8a4
>> --- /dev/null
>> +++ b/lib/tst_path_has_mnt_flags.c
>> @@ -0,0 +1,99 @@
>> +/*
>> + * Copyright (c) 2014 Fujitsu Ltd.
>> + * Author: Xing Gu <gux.fnst@cn.fujitsu.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms of version 2 of the GNU General Public License as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it would be useful, but
>> + * WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
>> + *
>> + * You should have received a copy of the GNU General Public License along
>> + * with this program; if not, write the Free Software Foundation, Inc.,
>> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>> + */
>> +
>> +#include <unistd.h>
>> +#include <mntent.h>
>> +#include "test.h"
>> +
>> +/*
>> + * Returns if prefix is prefix of a string and the lenght of prefix.
>> + */
>> +int strpref(const char *str, const char *pref)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; pref[i] != '\0'; i++) {
>> +		/* string ended too soon */
>> +		if (str[i] == 0)
>> +			return -1;
>> +
>> +		/* string is diferent */
>> +		if (str[i] != pref[i])
>> +			return -1;
>> +	}
>> +
>> +	/* returns lenght of prefix */
>> +	return i;
>> +}
>> +
>> +/*
>> + * Check whether a path is on a filesystem that is mounted with
>> + * specified flags.
>> + *
>> + * Returns:
>> + *   -1 - an error has occurred
>> + *   0 - the filesystem does not have any specified flags
>> + *   1 - the filesystem has at least one flag matched
>> + */
>> +int tst_path_has_mnt_flags(const char *path, const char *flags[])
>> +{
>> +	struct mntent *mnt;
>> +	int prefix_max = 0, prefix;
>> +	int has_flags = 0, has_opt;
>> +	FILE *f;
>> +	int i;
>> +
>> +	if (path == NULL) {
>> +		printf("The path is NULL.\n");
>> +		return -1;
>> +	}
>> +
>> +	if (access(path, F_OK) == -1) {
>> +		printf("The path %s doesn't exist.\n", path);
>> +		return -1;
>> +	}
>> +
>> +	f = setmntent("/proc/mounts", "r");
>> +
>> +	if (f == NULL) {
>> +		printf("Couldn't mount /proc/mounts.\n");
>> +		return -1;
>> +	}
>> +
>> +	while ((mnt = getmntent(f))) {
>> +		/* ignore all pseudo fs */
>> +		if (mnt->mnt_fsname[0] != '/')
>> +			continue;
>> +
>> +		prefix = strpref(path, mnt->mnt_dir);
> Hi,
>
> Can strpref() return anything other than -1 or strlen(mnt->mnt_dir)?
> How about using strncmp instead?
>
>      size_t prefix_len = strlen(mnt->mnt_dir);
>      if (strncmp(path, mnt->mnt_dir, prefix_len) == 0 && prefix_len > prefix_max) {
>          ...
>      }

Thank you for your comment. The code using strncmp() is better.

Regards,
Xing Gu


> Regards,
> Jan
>
>> +
>> +		if (prefix > prefix_max) {
>> +			prefix_max = prefix;
>> +			has_opt = 0;
>> +			i = 0;
>> +			while ((has_opt == 0) && (flags[i] != NULL)) {
>> +				has_opt = hasmntopt(mnt, flags[i]) != NULL;
>> +				i++;
>> +			}
>> +			has_flags = has_opt;
>> +		}
>> +	}
>> +
>> +	endmntent(f);
>> +
>> +	return has_flags;
>> +}
>> --
>> 1.8.3.1
>> ------------------------------------------------------------------------------
>> _______________________________________________
>> Ltp-list mailing list
>> Ltp-list@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/ltp-list
>>
> .
>


--------------090502030100020905010505
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <br>
    <div class="moz-cite-prefix">On 04/04/2014 06:01 PM, Jan Stancek
      wrote:<br>
    </div>
    <blockquote
      cite="mid:36493213.5963741.1396605704407.JavaMail.zimbra@redhat.com"
      type="cite">
      <pre wrap="">



----- Original Message -----
</pre>
      <blockquote type="cite">
        <pre wrap="">From: "gux fnst" <a class="moz-txt-link-rfc2396E" href="mailto:gux.fnst@cn.fujitsu.com">&lt;gux.fnst@cn.fujitsu.com&gt;</a>
To: <a class="moz-txt-link-abbreviated" href="mailto:ltp-list@lists.sourceforge.net">ltp-list@lists.sourceforge.net</a>
Sent: Thursday, 3 April, 2014 2:00:44 PM
Subject: [LTP] [PATCH v2 1/2] lib/tst_path_has_mnt_flags.c: create a function tst_path_has_mnt_flags()

Create a function tst_path_has_mnt_flags() for checking whether
a path is on a system that is mounted with specified flags.

Signed-off-by: Xing Gu <a class="moz-txt-link-rfc2396E" href="mailto:gux.fnst@cn.fujitsu.com">&lt;gux.fnst@cn.fujitsu.com&gt;</a>
---
 include/test.h               |  9 ++++
 lib/tst_path_has_mnt_flags.c | 99
 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+)
 create mode 100644 lib/tst_path_has_mnt_flags.c

diff --git a/include/test.h b/include/test.h
index baa3ef6..39bc5a1 100644
--- a/include/test.h
+++ b/include/test.h
@@ -295,6 +295,15 @@ gid_t tst_get_unused_gid(void);
 unsigned short tst_get_unused_port(void (cleanup_fn)(void),
 	unsigned short family, int type);
 
+/* lib/tst_path_has_mnt_flags.c
+ *
+ * Check whether a path is on a filesystem that is mounted with
+ * specified flags.
+ * @path: path to file
+ * @flags: mount flags
+ */
+int tst_path_has_mnt_flags(const char *path, const char *flags[]);
+
 #ifdef TST_USE_COMPAT16_SYSCALL
 #define TCID_BIT_SUFFIX "_16"
 #elif  TST_USE_NEWER64_SYSCALL
diff --git a/lib/tst_path_has_mnt_flags.c b/lib/tst_path_has_mnt_flags.c
new file mode 100644
index 0000000..257b8a4
--- /dev/null
+++ b/lib/tst_path_has_mnt_flags.c
@@ -0,0 +1,99 @@
+/*
+ * Copyright (c) 2014 Fujitsu Ltd.
+ * Author: Xing Gu <a class="moz-txt-link-rfc2396E" href="mailto:gux.fnst@cn.fujitsu.com">&lt;gux.fnst@cn.fujitsu.com&gt;</a>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#include &lt;unistd.h&gt;
+#include &lt;mntent.h&gt;
+#include "test.h"
+
+/*
+ * Returns if prefix is prefix of a string and the lenght of prefix.
+ */
+int strpref(const char *str, const char *pref)
+{
+	int i;
+
+	for (i = 0; pref[i] != '\0'; i++) {
+		/* string ended too soon */
+		if (str[i] == 0)
+			return -1;
+
+		/* string is diferent */
+		if (str[i] != pref[i])
+			return -1;
+	}
+
+	/* returns lenght of prefix */
+	return i;
+}
+
+/*
+ * Check whether a path is on a filesystem that is mounted with
+ * specified flags.
+ *
+ * Returns:
+ *   -1 - an error has occurred
+ *   0 - the filesystem does not have any specified flags
+ *   1 - the filesystem has at least one flag matched
+ */
+int tst_path_has_mnt_flags(const char *path, const char *flags[])
+{
+	struct mntent *mnt;
+	int prefix_max = 0, prefix;
+	int has_flags = 0, has_opt;
+	FILE *f;
+	int i;
+
+	if (path == NULL) {
+		printf("The path is NULL.\n");
+		return -1;
+	}
+
+	if (access(path, F_OK) == -1) {
+		printf("The path %s doesn't exist.\n", path);
+		return -1;
+	}
+
+	f = setmntent("/proc/mounts", "r");
+
+	if (f == NULL) {
+		printf("Couldn't mount /proc/mounts.\n");
+		return -1;
+	}
+
+	while ((mnt = getmntent(f))) {
+		/* ignore all pseudo fs */
+		if (mnt-&gt;mnt_fsname[0] != '/')
+			continue;
+
+		prefix = strpref(path, mnt-&gt;mnt_dir);
</pre>
      </blockquote>
      <pre wrap="">
Hi,

Can strpref() return anything other than -1 or strlen(mnt-&gt;mnt_dir)?
How about using strncmp instead?

    size_t prefix_len = strlen(mnt-&gt;mnt_dir);
    if (strncmp(path, mnt-&gt;mnt_dir, prefix_len) == 0 &amp;&amp; prefix_len &gt; prefix_max) {
        ...    
    }
</pre>
    </blockquote>
    <font size="3"><font face="MS Sans Serif"><font color="#000000"><br>
          Thank you for your comment. The code using strncmp() is
          better.</font></font></font><br>
    <br>
    Regards,<br>
    Xing Gu<br>
    <br>
    <br>
    <blockquote
      cite="mid:36493213.5963741.1396605704407.JavaMail.zimbra@redhat.com"
      type="cite">
      <pre wrap="">
Regards,
Jan

</pre>
      <blockquote type="cite">
        <pre wrap="">+
+		if (prefix &gt; prefix_max) {
+			prefix_max = prefix;
+			has_opt = 0;
+			i = 0;
+			while ((has_opt == 0) &amp;&amp; (flags[i] != NULL)) {
+				has_opt = hasmntopt(mnt, flags[i]) != NULL;
+				i++;
+			}
+			has_flags = has_opt;
+		}
+	}
+
+	endmntent(f);
+
+	return has_flags;
+}
--
1.8.3.1
------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Ltp-list@lists.sourceforge.net">Ltp-list@lists.sourceforge.net</a>
<a class="moz-txt-link-freetext" href="https://lists.sourceforge.net/lists/listinfo/ltp-list">https://lists.sourceforge.net/lists/listinfo/ltp-list</a>

</pre>
      </blockquote>
      <pre wrap="">.

</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------090502030100020905010505--


--===============5335955892431550764==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Put Bad Developers to Shame
Dominate Development with Jenkins Continuous Integration
Continuously Automate Build, Test & Deployment 
Start a new project now. Try Jenkins in the cloud.
http://p.sf.net/sfu/13600_Cloudbees
--===============5335955892431550764==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5335955892431550764==--

