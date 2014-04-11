Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gux.fnst@cn.fujitsu.com>) id 1WYUrd-0004Af-1o
	for ltp-list@lists.sourceforge.net; Fri, 11 Apr 2014 06:23:01 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WYUra-0006Aw-5O
	for ltp-list@lists.sourceforge.net; Fri, 11 Apr 2014 06:23:00 +0000
Message-ID: <53478A2A.7070506@cn.fujitsu.com>
Date: Fri, 11 Apr 2014 14:22:34 +0800
From: "gux.fnst" <gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
References: <1396526450-22885-1-git-send-email-gux.fnst@cn.fujitsu.com>
	<1397015193-18623-1-git-send-email-gux.fnst@cn.fujitsu.com>
	<472091851.2162463.1397039648410.JavaMail.zimbra@redhat.com>
In-Reply-To: <472091851.2162463.1397039648410.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH v3] lib/tst_path_has_mnt_flags.c: create a
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
Content-Type: multipart/mixed; boundary="===============4093569727186120620=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

--===============4093569727186120620==
Content-Type: multipart/alternative;
	boundary="------------070403080207090007080304"

--------------070403080207090007080304
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit


On 04/09/2014 06:34 PM, Jan Stancek wrote:
>
>
>
> ----- Original Message -----
>> From: "gux fnst" <gux.fnst@cn.fujitsu.com>
>> To: ltp-list@lists.sourceforge.net
>> Sent: Wednesday, 9 April, 2014 5:46:34 AM
>> Subject: [LTP] [PATCH v3] lib/tst_path_has_mnt_flags.c: create a function tst_path_has_mnt_flags()
>>
>> Create a function tst_path_has_mnt_flags() for checking whether
>> a path is on a system that is mounted with specified flags.
>>
>> Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
>> ---
>>   include/test.h               |  9 +++++
>>   lib/tst_path_has_mnt_flags.c | 79
>>   ++++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 88 insertions(+)
>>
>> +
>> +		prefix_len = strlen(mnt->mnt_dir);
>> +
>> +		if (strncmp(path, mnt->mnt_dir, prefix_len) == 0
>> +				&& prefix_len > prefix_max) {
>> +			prefix_max = prefix_len;
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
> This function looks OK for one testcase that needs to check for
> OR logic between flags. I was thinking, whether we should change
> this function to return number matched flags. That way we could
> also check easily for AND logic (matches all flags) if we need
> that in future.
>
>
>    * Returns:
>    *   -1 - an error has occurred
>    *   0 - the filesystem does not have any specified flags
> - *   1 - the filesystem has at least one flag matched
> + *   1..n - number of flags matched
>    */
>   int tst_path_has_mnt_flags(const char *path, const char *flags[])
>   {
>          struct mntent *mnt;
>          size_t prefix_max = 0, prefix_len;
> -       int has_flags = 0, has_opt;
> +       int flags_matched = 0;
>          FILE *f;
>          int i;
>   
> @@ -63,17 +65,24 @@ int tst_path_has_mnt_flags(const char *path, const char *flags[])
>                  if (strncmp(path, mnt->mnt_dir, prefix_len) == 0
>                                  && prefix_len > prefix_max) {
>                          prefix_max = prefix_len;
> -                       has_opt = 0;
> +                       flags_matched = 0;
>                          i = 0;
> -                       while ((has_opt == 0) && (flags[i] != NULL)) {
> -                               has_opt = hasmntopt(mnt, flags[i]) != NULL;
> +                       while (flags[i] != NULL) {
> +                               if (hasmntopt(mnt, flags[i]) != NULL)
> +                                       flags_matched++;
>                                  i++;
>                          }
> -                       has_flags = has_opt;
>                  }
>          }
>   
>          endmntent(f);
>   
> -       return has_flags;
> +       return flags_matched;
> +}
>
> What do you think?

Thanks for your suggestion. It is very helpfull.
I will send a new version today.

Regards,
Xing Gu
>
> Regards,
> Jan
>
>> --
>> 1.8.3.1
>> ------------------------------------------------------------------------------
>> Put Bad Developers to Shame
>> Dominate Development with Jenkins Continuous Integration
>> Continuously Automate Build, Test & Deployment
>> Start a new project now. Try Jenkins in the cloud.
>> http://p.sf.net/sfu/13600_Cloudbees
>> _______________________________________________
>> Ltp-list mailing list
>> Ltp-list@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/ltp-list
>>
> .
>


--------------070403080207090007080304
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <br>
    <div class="moz-cite-prefix">On 04/09/2014 06:34 PM, Jan Stancek
      wrote:<br>
    </div>
    <blockquote
      cite="mid:472091851.2162463.1397039648410.JavaMail.zimbra@redhat.com"
      type="cite">
      <pre wrap="">



----- Original Message -----
</pre>
      <blockquote type="cite">
        <pre wrap="">From: "gux fnst" <a class="moz-txt-link-rfc2396E" href="mailto:gux.fnst@cn.fujitsu.com">&lt;gux.fnst@cn.fujitsu.com&gt;</a>
To: <a class="moz-txt-link-abbreviated" href="mailto:ltp-list@lists.sourceforge.net">ltp-list@lists.sourceforge.net</a>
Sent: Wednesday, 9 April, 2014 5:46:34 AM
Subject: [LTP] [PATCH v3] lib/tst_path_has_mnt_flags.c: create a function tst_path_has_mnt_flags()

Create a function tst_path_has_mnt_flags() for checking whether
a path is on a system that is mounted with specified flags.

Signed-off-by: Xing Gu <a class="moz-txt-link-rfc2396E" href="mailto:gux.fnst@cn.fujitsu.com">&lt;gux.fnst@cn.fujitsu.com&gt;</a>
---
 include/test.h               |  9 +++++
 lib/tst_path_has_mnt_flags.c | 79
 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+)

+
+		prefix_len = strlen(mnt-&gt;mnt_dir);
+
+		if (strncmp(path, mnt-&gt;mnt_dir, prefix_len) == 0
+				&amp;&amp; prefix_len &gt; prefix_max) {
+			prefix_max = prefix_len;
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
</pre>
      </blockquote>
      <pre wrap="">
This function looks OK for one testcase that needs to check for
OR logic between flags. I was thinking, whether we should change
this function to return number matched flags. That way we could
also check easily for AND logic (matches all flags) if we need
that in future.


  * Returns:
  *   -1 - an error has occurred
  *   0 - the filesystem does not have any specified flags
- *   1 - the filesystem has at least one flag matched
+ *   1..n - number of flags matched
  */
 int tst_path_has_mnt_flags(const char *path, const char *flags[])
 {
        struct mntent *mnt;
        size_t prefix_max = 0, prefix_len;
-       int has_flags = 0, has_opt;
+       int flags_matched = 0;
        FILE *f;
        int i;
 
@@ -63,17 +65,24 @@ int tst_path_has_mnt_flags(const char *path, const char *flags[])
                if (strncmp(path, mnt-&gt;mnt_dir, prefix_len) == 0
                                &amp;&amp; prefix_len &gt; prefix_max) {
                        prefix_max = prefix_len;
-                       has_opt = 0;
+                       flags_matched = 0;
                        i = 0;
-                       while ((has_opt == 0) &amp;&amp; (flags[i] != NULL)) {
-                               has_opt = hasmntopt(mnt, flags[i]) != NULL;
+                       while (flags[i] != NULL) {
+                               if (hasmntopt(mnt, flags[i]) != NULL)
+                                       flags_matched++;
                                i++;
                        }
-                       has_flags = has_opt;
                }
        }
 
        endmntent(f);
 
-       return has_flags;
+       return flags_matched;
+}

What do you think?</pre>
    </blockquote>
    <font size="3"><font face="MS Sans Serif"><br>
        Thanks for your suggestion. It is very helpfull.</font></font><br>
    I will send a new version today.<br>
    <br>
    Regards,<br>
    Xing Gu<br>
    <blockquote
      cite="mid:472091851.2162463.1397039648410.JavaMail.zimbra@redhat.com"
      type="cite">
      <pre wrap="">

Regards,
Jan

</pre>
      <blockquote type="cite">
        <pre wrap="">--
1.8.3.1
------------------------------------------------------------------------------
Put Bad Developers to Shame
Dominate Development with Jenkins Continuous Integration
Continuously Automate Build, Test &amp; Deployment
Start a new project now. Try Jenkins in the cloud.
<a class="moz-txt-link-freetext" href="http://p.sf.net/sfu/13600_Cloudbees">http://p.sf.net/sfu/13600_Cloudbees</a>
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

--------------070403080207090007080304--


--===============4093569727186120620==
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
--===============4093569727186120620==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4093569727186120620==--

