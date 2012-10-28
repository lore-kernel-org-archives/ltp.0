Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <tdmackey@twitter.com>) id 1TSZnA-00031i-GZ
	for ltp-list@lists.sourceforge.net; Sun, 28 Oct 2012 20:49:08 +0000
Received: from mail-vc0-f175.google.com ([209.85.220.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1TSZn9-0007yZ-RB
	for ltp-list@lists.sourceforge.net; Sun, 28 Oct 2012 20:49:08 +0000
Received: by mail-vc0-f175.google.com with SMTP id p1so5006412vcq.34
	for <ltp-list@lists.sourceforge.net>;
	Sun, 28 Oct 2012 13:49:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1351413491-18760-1-git-send-email-tdmackey@twitter.com>
References: <1351413491-18760-1-git-send-email-tdmackey@twitter.com>
From: David Mackey <tdmackey@twitter.com>
Date: Sun, 28 Oct 2012 13:48:32 -0700
Message-ID: <CAMrBRo1HCuZ0GdwTE5Qxx3ygsH1jA6kxRVDw4QYxLsj1kjH8Qg@mail.gmail.com>
Subject: Re: [LTP] [PATCH] proc01: Add EAGAIN to known issues for acpi/event
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1594405193481772304=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============1594405193481772304==
Content-Type: multipart/alternative; boundary=14dae9ccd476d090a604cd24ae65

--14dae9ccd476d090a604cd24ae65
Content-Type: text/plain; charset=UTF-8

On Sun, Oct 28, 2012 at 1:38 AM, David Mackey <tdmackey@twitter.com> wrote:

> Calling open on /proc/acpi/event with O_NONBLOCK will return EAGAIN if
> the acpi bus event list is empty and no process is listening for events.
> This is a common errno if acpid is not running.
>
> - Add EAGAIN to known issues list for /proc/acpi/event.
>
> Signed-off-by: David Mackey <tdmackey@twitter.com>
> ---
>  testcases/kernel/fs/proc/proc01.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/testcases/kernel/fs/proc/proc01.c
> b/testcases/kernel/fs/proc/proc01.c
> index a6fb3d9..1c2b392 100644
> --- a/testcases/kernel/fs/proc/proc01.c
> +++ b/testcases/kernel/fs/proc/proc01.c
> @@ -82,6 +82,7 @@ typedef struct mapping Mapping;
>     like if SELinux is disabled, the test may still fail on some other
>     entries. */
>  const Mapping known_issues[] = {
> +    {"open", "/proc/acpi/event", EAGAIN},
>      {"open", "/proc/acpi/event", EBUSY},
>      {"open", "/proc/sal/cpe/data", EBUSY},
>      {"open", "/proc/sal/cmc/data", EBUSY},
> --
> 1.7.11.7
>
>
Please discard. Will resubmit.

--14dae9ccd476d090a604cd24ae65
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 28, 2012 at 1:38 AM, David Mackey <span dir=3D"ltr">&lt;<a href=
=3D"mailto:tdmackey@twitter.com" target=3D"_blank">tdmackey@twitter.com</a>=
&gt;</span> wrote:<br><div class=3D"gmail_quote"><blockquote class=3D"gmail=
_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:=
1ex">

Calling open on /proc/acpi/event with O_NONBLOCK will return EAGAIN if<br>
the acpi bus event list is empty and no process is listening for events.<br=
>
This is a common errno if acpid is not running.<br>
<br>
- Add EAGAIN to known issues list for /proc/acpi/event.<br>
<br>
Signed-off-by: David Mackey &lt;<a href=3D"mailto:tdmackey@twitter.com">tdm=
ackey@twitter.com</a>&gt;<br>
---<br>
=C2=A0testcases/kernel/fs/proc/proc01.c | 1 +<br>
=C2=A01 file changed, 1 insertion(+)<br>
<br>
diff --git a/testcases/kernel/fs/proc/proc01.c b/testcases/kernel/fs/proc/p=
roc01.c<br>
index a6fb3d9..1c2b392 100644<br>
--- a/testcases/kernel/fs/proc/proc01.c<br>
+++ b/testcases/kernel/fs/proc/proc01.c<br>
@@ -82,6 +82,7 @@ typedef struct mapping Mapping;<br>
=C2=A0 =C2=A0 like if SELinux is disabled, the test may still fail on some =
other<br>
=C2=A0 =C2=A0 entries. */<br>
=C2=A0const Mapping known_issues[] =3D {<br>
+ =C2=A0 =C2=A0{&quot;open&quot;, &quot;/proc/acpi/event&quot;, EAGAIN},<br=
>
=C2=A0 =C2=A0 =C2=A0{&quot;open&quot;, &quot;/proc/acpi/event&quot;, EBUSY}=
,<br>
=C2=A0 =C2=A0 =C2=A0{&quot;open&quot;, &quot;/proc/sal/cpe/data&quot;, EBUS=
Y},<br>
=C2=A0 =C2=A0 =C2=A0{&quot;open&quot;, &quot;/proc/sal/cmc/data&quot;, EBUS=
Y},<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
1.7.11.7<br>
<br></font></span></blockquote><div><br></div><div>Please discard. Will res=
ubmit.=C2=A0</div></div><br>

--14dae9ccd476d090a604cd24ae65--


--===============1594405193481772304==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
WINDOWS 8 is here. 
Millions of people.  Your app in 30 days.
Visit The Windows 8 Center at Sourceforge for all your go to resources.
http://windows8center.sourceforge.net/
join-generation-app-and-make-money-coding-fast/
--===============1594405193481772304==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1594405193481772304==--

