Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PAerr-00080e-60
	for ltp-list@lists.sourceforge.net; Tue, 26 Oct 2010 08:26:51 +0000
Received: from mail-ww0-f41.google.com ([74.125.82.41])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PAero-0004Yz-VS
	for ltp-list@lists.sourceforge.net; Tue, 26 Oct 2010 08:26:51 +0000
Received: by wwb17 with SMTP id 17so1102873wwb.4
	for <ltp-list@lists.sourceforge.net>;
	Tue, 26 Oct 2010 01:26:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTikZ4ct8be_ROsUHrbGygH61sgq5FS6dqPJO0-ps@mail.gmail.com>
References: <1870824414.1492961288080127619.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
	<2034750582.1493141288080254753.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
	<AANLkTikZ4ct8be_ROsUHrbGygH61sgq5FS6dqPJO0-ps@mail.gmail.com>
Date: Tue, 26 Oct 2010 01:26:43 -0700
Message-ID: <AANLkTikk=cGee7xyhzi3mFmVoQYk64Ha1x6Z5D0QYfyo@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] fix keyctl01 testcase on s390x systems
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Caspar Zhang <czhang@redhat.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

On Tue, Oct 26, 2010 at 1:16 AM, Garrett Cooper <yanegomi@gmail.com> wrote:
> On Tue, Oct 26, 2010 at 1:04 AM, Caspar Zhang <czhang@redhat.com> wrote:
>> Hi all,
>>
>> on s390x systems, a string like "MyKey" is not a valid argument
>> for keyctl syscall function, I substitute the string by number
>> to make keyctl testcase work on s390x systems.
>>
>> use "MyKey":
>>
>> keyctl01 =A0 =A01 =A0TPASS =A0: =A0KEYCTL_GET_KEYRING_ID succeeded
>> keyctl01 =A0 =A02 =A0TFAIL =A0: =A0KEYCTL_REVOKE got unexpected errno: e=
rrno=3DEINVAL(22): Invalid argument
>>
>> use a number:
>>
>> keyctl01 =A0 =A01 =A0TPASS =A0: =A0KEYCTL_GET_KEYRING_ID succeeded
>> keyctl01 =A0 =A02 =A0TPASS =A0: =A0KEYCTL_REVOKE got expected errno: err=
no=3D???(126): Required key not available
>>
>> Signed-off-by: Caspar Zhang <czhang@redhat.com>
>
> =A0 =A0Looks like a kernel bug to me:
> http://manpages.ubuntu.com/manpages/lucid/man3/keyctl_revoke.3.html .
> EINVAL isn't listed in the manpage.

    FWIW though, the testcase is sort of bogus anyhow by sending in a
pointer to a static char buffer instead of int32_t...

(see http://linux.die.net/man/3/keyctl_revoke )

include/linux/key.h:typedef int32_t key_serial_t;
include/linux/key.h:	key_serial_t		serial;		/* key serial number */
include/linux/key.h:extern struct key *key_lookup(key_serial_t id);
include/linux/key.h:static inline key_serial_t key_serial(struct key *key)
include/linux/lsm_audit.h:			key_serial_t key;
include/linux/syscalls.h:			    key_serial_t destringid);
include/linux/syscalls.h:				key_serial_t destringid);

    So there are two bugs here. The most futureproof way to fix this
is to do do linear probing with something like keyctl(KEYCTL_UNLINK,
i) until you find a value i that isn't already allocated; it might be
wise to linearly probe backwards from INT32_MAX.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Nokia and AT&T present the 2010 Calling All Innovators-North America contest
Create new apps & games for the Nokia N8 for consumers in  U.S. and Canada
$10 million total in prizes - $4M cash, 500 devices, nearly $6M in marketing
Develop with Nokia Qt SDK, Web Runtime, or Java and Publish to Ovi Store =

http://p.sf.net/sfu/nokia-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
