Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1OnSDP-0001Lk-BX
	for ltp-list@lists.sourceforge.net; Mon, 23 Aug 2010 08:17:11 +0000
Received: from mail-bw0-f47.google.com ([209.85.214.47])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OnSDO-00065W-8Z
	for ltp-list@lists.sourceforge.net; Mon, 23 Aug 2010 08:17:11 +0000
Received: by bwz12 with SMTP id 12so5161846bwz.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 23 Aug 2010 01:17:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <SNT119-W322DCC7E0FF2E9370D214E94820@phx.gbl>
References: <SNT119-W3821029ADE3BBEE190C837949F0@phx.gbl>
	<D2E04B18-BD6D-458D-A41E-BD8BC095E9F1@gmail.com>
	<SNT119-W322DCC7E0FF2E9370D214E94820@phx.gbl>
Date: Mon, 23 Aug 2010 01:17:03 -0700
Message-ID: <AANLkTinL-auVn5Mm2=mc261LYkjiZYbGm_kABJCnqYG=@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Content-Type: multipart/mixed; boundary=001636c5a522fb097b048e79455e
Subject: Re: [LTP]
	=?utf-8?q?=5BPATCH=5Dfix_the_at=5Fdeny01_failure=E2=80=8F?=
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Godwin Gao <godwin.gao@hotmail.com>
Cc: ltp-list@lists.sourceforge.net

--001636c5a522fb097b048e79455e
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

2010/8/23 Godwin Gao <godwin.gao@hotmail.com>:
> Retested the at_deny01 case, and found the same issue[2]. The below is th=
e
> test steps, if something wrong, please note me.
>
> 1. create a runtest/at file
> root@godwin-desktop:/home/godwin/LTP_New/ltp-full-20100630# cat runtest/a=
t
> at_deny01=A0=A0=A0 at_deny01
> 2. fixed the issue[1]
> 3. ./runltp -p -l a.txt -f at
>
> Seems it is a environment setup issue, test_user_1 does not have the
> ${LTPROOT}/testcases/bin in its PATH.
> Attached the log

    Ok, I see the issue now:

=91-=92
=91-l=92
=91--login=92
    Make the shell a login shell. This means the following. Unset all
environment variables except TERM, HOME, and SHELL (which are set as
described above), and USER and LOGNAME (which are set, even for the
super-user, as described above), and set PATH to a compiled-in default
value. Change to user's home directory. Prepend =91-=92 to the shell's
name, intended to make it read its login startup file(s).

    Note that it's a `precompiled' path (BSD explicitly calls this out
as /bin:/usr/bin, but who knows what Linux sets this as).
    Here's a quick patch for this item; please let me know how it
works in the negative case.
Thanks,
-Garrett

PS The reason why I did this was to avoid environment tainting as
setup_test says:

        # This is the workaround for a potential bug.
        # [Bug 468337] At Refuse to Work with Non-login Shell
        # https://bugzilla.redhat.com/show_bug.cgi?id=3D468337
        # As we are running in non-login shell now, we cannot run the scrip=
t
        # by simply given it a relative path. Therefore, we copy it to test
        # users' home directories, and run it from there.

because -m/-p would have done just that (besides... environment
tainting just makes crud non-deterministic...).

--001636c5a522fb097b048e79455e
Content-Type: application/octet-stream; 
	name="fix-at_deny01-error-conditions.diff"
Content-Disposition: attachment; 
	filename="fix-at_deny01-error-conditions.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gd71zf9s2

ZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9jb21tYW5kcy9hdC9hdF9kZW55MDEgYi90ZXN0Y2FzZXMv
Y29tbWFuZHMvYXQvYXRfZGVueTAxCmluZGV4IGRjZWM2ODQuLjFiYTJiZmIgMTAwNzU1Ci0tLSBh
L3Rlc3RjYXNlcy9jb21tYW5kcy9hdC9hdF9kZW55MDEKKysrIGIvdGVzdGNhc2VzL2NvbW1hbmRz
L2F0L2F0X2RlbnkwMQpAQCAtMzQsOCArMzQsOCBAQCBUTVA9JHtUTVA6PS90bXB9CiBkZW55PSIv
ZXRjL2F0LmRlbnkiCiB0ZXN0X3VzZXIxPSJ0ZXN0X3VzZXJfMSIKIHRlc3RfdXNlcjI9InRlc3Rf
dXNlcl8yIgotdGVzdF91c2VyMl9ob21lPSIvaG9tZS8ke3Rlc3RfdXNlcjJ9IgogdGVzdF91c2Vy
MV9ob21lPSIvaG9tZS8ke3Rlc3RfdXNlcjF9IgordGVzdF91c2VyMl9ob21lPSIvaG9tZS8ke3Rl
c3RfdXNlcjJ9IgogdG1wZmlsZT0iJFRNUC9hdF9kZW55X3Rlc3QiCiAKICMtLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQpAQCAtNzksNiArNzksMTIgQEAgZG9fc2V0dXAoKQogCSMgdXNlcnMnIGhvbWUgZGlyZWN0b3Jp
ZXMsIGFuZCBydW4gaXQgZnJvbSB0aGVyZS4KIAljcCAiJDAiICIke3Rlc3RfdXNlcjFfaG9tZX0v
LiIKIAljcCAiJDAiICIke3Rlc3RfdXNlcjJfaG9tZX0vLiIKKwllY2hvICJleHBvcnQgTFRQUk9P
VD0nJExUUFJPT1QnIiA+ICIke3Rlc3RfdXNlcjFfaG9tZX0vY2FjaGVkX2x0cHJvb3QiCisJZWNo
byAiZXhwb3J0IExUUFJPT1Q9JyRMVFBST09UJyIgPiAiJHt0ZXN0X3VzZXIyX2hvbWV9L2NhY2hl
ZF9sdHByb290IgorCWlmIFsgJD8gLW5lIDAgXTsgdGhlbgorCQl0c3RfcmVzbSBUQlJPSyAiQ291
bGRuJ3QgY29weSBvdmVyIHJlcSdkIGZpbGVzIGZvciB0ZXN0IHVzZXJzIgorCQlleGl0IDEKKwlm
aQogCiAJIyBSZXN0YXJ0IGF0ZCBkYWVtb24uCiAJL2V0Yy9pbml0LmQvYXRkIHJlc3RhcnQKQEAg
LTEwOSw2ICsxMTUsOSBAQCBkb19jbGVhbnVwKCkKIHJ1bl90ZXN0KCkKIHsKIAlpZiBbICQod2hv
YW1pKSA9ICIke3Rlc3RfdXNlcjF9IiBdOyB0aGVuIAorCQkuICIke3Rlc3RfdXNlcjFfaG9tZX0v
Y2FjaGVkX2x0cHJvb3QiIHx8IGV4aXQgMQorCQlleHBvcnQgUEFUSD0iJFBBVEg6JExUUFJPT1Qv
dGVzdGNhc2VzL2JpbiIKKwogCQllY2hvICJURVNUOiAke2Rlbnl9IHNob3VsZCBkZW55IG9ubHkg
dGhvc2Ugd2hvIGFyZSBub3QgaW4gdGhlIGZpbGUgdG8gcnVuIGpvYnMuIgogCQllY2hvICIoMSkg
VEVTVCBUSEFUIFBFUlNPTiBOT1QgSU4gJHtkZW55fSBJUyBBQkxFIFRPIFJVTiBKT0IuIgogCQll
Y2hvICJlY2hvICdURVNUIEpPQiBSQU4nID4+XCIke3RtcGZpbGV9XCIgMj4mMSIgfApAQCAtMTMx
LDYgKzE0MCwxMCBAQCBydW5fdGVzdCgpCiAJCWV4aXQgJHtleGl0X2NvZGV9CiAKIAllbGlmIFsg
JCh3aG9hbWkpID0gIiR7dGVzdF91c2VyMn0iIF07IHRoZW4KKworCQkuICIke3Rlc3RfdXNlcjJf
aG9tZX0vY2FjaGVkX2x0cHJvb3QiIHx8IGV4aXQgMQorCQlleHBvcnQgUEFUSD0iJFBBVEg6JExU
UFJPT1QvdGVzdGNhc2VzL2JpbiIKKwogCQllY2hvICIoMikgVEVTVCBUSEFUIFBFUlNPTiBJTiAk
e2Rlbnl9IElTIE5PVCBBQkxFIFRPIFJVTiBKT0IuIgogCiAJCWVjaG8gImVjaG8gJ1RFU1QgSk9C
IFJBTicgPj5cIiR7dG1wZmlsZX1cIiAyPiYxIiB8Cg==
--001636c5a522fb097b048e79455e
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by 

Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev 
--001636c5a522fb097b048e79455e
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--001636c5a522fb097b048e79455e--

