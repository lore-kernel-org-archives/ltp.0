Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1UoUyO-0005y3-3U
	for ltp-list@lists.sourceforge.net; Mon, 17 Jun 2013 08:39:36 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UoUyM-0007Xr-Ho
	for ltp-list@lists.sourceforge.net; Mon, 17 Jun 2013 08:39:35 +0000
Message-ID: <51BECB27.2000104@oracle.com>
Date: Mon, 17 Jun 2013 12:39:03 +0400
From: alexey.kodanev@oracle.com
MIME-Version: 1.0
References: <1371208652-25804-1-git-send-email-alexey.kodanev@oracle.com>
	<104332332.3007867.1371217696167.JavaMail.root@redhat.com>
	<51BB2C58.4040405@oracle.com>
	<2134219040.3111091.1371222971601.JavaMail.root@redhat.com>
In-Reply-To: <2134219040.3111091.1371222971601.JavaMail.root@redhat.com>
Subject: Re: [LTP] [PATCH v2] fw_load: new test of device firmware loading
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1812166893887193292=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Jan Stancek <jstancek@redhat.com>
Cc: vasily isaenko <vasily.isaenko@oracle.com>, ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.
--===============1812166893887193292==
Content-Type: multipart/alternative;
	boundary="------------040100000708090709010502"

This is a multi-part message in MIME format.
--------------040100000708090709010502
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by userp1040.oracle.com id
	r5H8dPRr030454


On 06/14/2013 07:16 PM, Jan Stancek wrote:
>
>>> I ran this on older kernel, which worked fine - it skipped the build.
>>> Then I tried RHEL7 alpha, which has more recent kernel: 3.10.0-0.rc4,
>>> but it failed:
>>>
>>> # ./fw_load
>>> cp: cannot stat =E2=80=98/lib/udev/rules.d/50-firmware.rules=E2=80=99=
: No such file or
>>> directory
>>> fw_load     1  TBROK  :  Failed to copy
>>> '/lib/udev/rules.d/50-firmware.rules' to '/etc/udev/rules.d/' at
>>> fw_load.c:164
>>> fw_load     2  TBROK  :  Remaining cases broken
>>> fw_load     0  TWARN  :  tst_rmdir: TESTDIR was NULL; no removal atte=
mpted
>>>
>>> I'll see if I can find out what happened to 50-firmware.rules,
>>> it could some side-effect of systemd.
>>>
>> Would it be better to change failed copy command to just TWARN, and
>> continue testing? After that, test will completed with udev failed
>> test-cases, or if udev has those rules in the other configuration file=
s,
>> everything will be fine.
> I'd go with TCONF or skip udev testcases if we can't be sure that udev =
is running
> and properly configured.
>
> I'm also missing firmware.sh, in new udev (now merged with systemd tree=
),
> 50-firmware.rules file depends on some compile switch. Even when enable=
d
> the rule looks like this:
> http://cgit.freedesktop.org/systemd/systemd/tree/rules/50-firmware.rule=
s
>
> firmware.sh appears to be converted to .c now:
> http://cgit.freedesktop.org/systemd/systemd/tree/src/udev/udev-builtin-=
firmware.
I see now, I think it is better to skip udev in the test entirely,=20
because there is a tendency
in kernel community to disable user-mode helper firmware loading (udev).=20
It is already guarded with
CONFIG_FW_LOADER_USER_HELPER option in firmware code: firmware: Make=20
user-mode helper optional=20
<http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?i=
d=3D7b1269f778782d2f42994a74bf4014d0cbebbf9f>.
There is only one use of it: loading firmware from non-standard path. It=20
might also go away as soon as
configuring paths support had been added to kernel.

Thanks,
Alexey


--------------040100000708090709010502
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by userp1040.oracle.com id
	r5H8dPRr030454

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta content=3D"text/html; charset=3DUTF-8" http-equiv=3D"Content-Ty=
pe">
    <title></title>
  </head>
  <body text=3D"#000000" bgcolor=3D"#ffffff">
    <br>
    On 06/14/2013 07:16 PM, Jan Stancek wrote:
    <blockquote
      cite=3D"mid:2134219040.3111091.1371222971601.JavaMail.root@redhat.c=
om"
      type=3D"cite"><br>
      <blockquote type=3D"cite">
        <blockquote type=3D"cite">
          <pre wrap=3D"">
I ran this on older kernel, which worked fine - it skipped the build.
Then I tried RHEL7 alpha, which has more recent kernel: 3.10.0-0.rc4,
but it failed:

# ./fw_load
cp: cannot stat =E2=80=98/lib/udev/rules.d/50-firmware.rules=E2=80=99: No=
 such file or
directory
fw_load     1  TBROK  :  Failed to copy
'/lib/udev/rules.d/50-firmware.rules' to '/etc/udev/rules.d/' at
fw_load.c:164
fw_load     2  TBROK  :  Remaining cases broken
fw_load     0  TWARN  :  tst_rmdir: TESTDIR was NULL; no removal attempte=
d

I'll see if I can find out what happened to 50-firmware.rules,
it could some side-effect of systemd.

</pre>
        </blockquote>
        <pre wrap=3D"">Would it be better to change failed copy command t=
o just TWARN, and
continue testing? After that, test will completed with udev failed
test-cases, or if udev has those rules in the other configuration files,
everything will be fine.
</pre>
      </blockquote>
      <pre wrap=3D"">
I'd go with TCONF or skip udev testcases if we can't be sure that udev is=
 running
and properly configured.

I'm also missing firmware.sh, in new udev (now merged with systemd tree),
50-firmware.rules file depends on some compile switch. Even when enabled
the rule looks like this:
<a class=3D"moz-txt-link-freetext" href=3D"http://cgit.freedesktop.org/sy=
stemd/systemd/tree/rules/50-firmware.rules">http://cgit.freedesktop.org/s=
ystemd/systemd/tree/rules/50-firmware.rules</a>

firmware.sh appears to be converted to .c now:
<a class=3D"moz-txt-link-freetext" href=3D"http://cgit.freedesktop.org/sy=
stemd/systemd/tree/src/udev/udev-builtin-firmware">http://cgit.freedeskto=
p.org/systemd/systemd/tree/src/udev/udev-builtin-firmware</a>.</pre>
    </blockquote>
    I see now, I think it is better to skip udev in the test entirely,
    because there is a tendency<br>
    in kernel community to disable user-mode helper firmware loading
    (udev). It is already guarded with<br>
    CONFIG_FW_LOADER_USER_HELPER option in firmware code: <a
href=3D"http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3D7b1269f778782d2f42994a74bf4014d0cbebbf9f">firmware:
      Make user-mode helper optional</a>.<br>
    There is only one use of it: loading firmware from non-standard
    path. It might also go away as soon as<br>
    configuring paths support had been added to kernel.<br>
    <br>
    Thanks,<br>
    Alexey<br>
    <br>
  </body>
</html>

--------------040100000708090709010502--


--===============1812166893887193292==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
--===============1812166893887193292==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1812166893887193292==--

