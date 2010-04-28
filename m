Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <casparant@gmail.com>) id 1O70sG-00052Z-8M
	for ltp-list@lists.sourceforge.net; Wed, 28 Apr 2010 06:35:56 +0000
Received: from mail-pw0-f46.google.com ([209.85.160.46])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1O70sF-0002oa-9R
	for ltp-list@lists.sourceforge.net; Wed, 28 Apr 2010 06:35:56 +0000
MIME-Version: 1.0
In-Reply-To: <8B8139E0-F07A-433D-B38D-30DAB81E3FF5@gmail.com>
References: <103530624.1121001272433642504.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
	<8B8139E0-F07A-433D-B38D-30DAB81E3FF5@gmail.com>
From: Caspar Zhang <casparant@gmail.com>
Date: Wed, 28 Apr 2010 14:27:57 +0800
Message-ID: <s2r700385ec1004272327n8b26491bt3609f8877b71a385@mail.gmail.com>
Content-Type: multipart/mixed; boundary=00504502c13892382c0485461dd1
Subject: Re: [LTP] UTIMENSAT test fails hugely
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list <ltp-list@lists.sf.net>

--00504502c13892382c0485461dd1
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Apr 28, 2010 at 2:04 PM, Garrett Cooper <yanegomi@gmail.com> wrote:
> The first item is different from the other two. The first one ignores the
> signal (SIG_IGN), whereas the latter two cases reset the handler to the
> default one (SIG_DFL). I prefer the former format, because otherwise the
> signal handlers become reentrable on accident.

I see. Thank you.

The final patch ;-)

Cheers,
-Caspar

-- 
Tags: Ant, Beijing, BUPT, Caspar, Kernel QA, Linux, Open Source,
Photography, Programmer, Red Hat Inc., Zhejianger, etc.

Current: Kernel Associate Quality Engineer @ Red Hat Inc.

Home Page: http://www.CasparZhang.com/

--00504502c13892382c0485461dd1
Content-Type: text/x-patch; charset=US-ASCII; 
	name="syscalls-utimensat01-run-sudo-without-tty.patch"
Content-Disposition: attachment; 
	filename="syscalls-utimensat01-run-sudo-without-tty.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g8jrnrp80

SGksCglNb3N0IGF1dG9tYXRlZCB0ZXN0aW5nIHN5c3RlbXMgaGF2ZSBubyB0dHkgd2hlbiBydW5u
aW5nIHRlc3RzLAoJc28gdGhlIHV0aW1lbnNhdDAxIHRlc3QgbWF5IGZhaWwgd2l0aCB0aGUgZm9s
bG93aW5nIGVycm9yIG1zZzoKCglzdWRvOiBzb3JyeSwgeW91IG11c3QgaGF2ZSBhIHR0eSB0byBy
dW4gc3VkbwoKCXRvIGF2b2lkIHRoaXMsIGNvbW1lbnRpbmcgYERlZmF1bHRzICAgIHJlcXVpcmV0
dHknIGxpbmUgaW4KCS9ldGMvc3Vkb2VycyBjYW4gbWFrZSB0aGlzIHRlc3RjYXNlIHdvcmsuIEFm
dGVyIHRlc3QgZmluaXNoZWQsCglyZXN0b3JlIHRoaXMgbGluZS4KCglTaWduZWQtb2ZmLWJ5OiBD
YXNwYXIgWmhhbmcgPGN6aGFuZ0ByZWRoYXQuY29tPgotLS0KZGlmZiAtLWdpdCBhL3Rlc3RjYXNl
cy9rZXJuZWwvc3lzY2FsbHMvdXRpbWVuc2F0L3V0aW1lbnNhdF90ZXN0cy5zaCBiL3Rlc3RjYXNl
cy9rZXJuZWwvc3lzY2FsbHMvdXRpbWVuc2F0L3V0aW1lbnNhdF90ZXN0cy5zaAotLS0gYS90ZXN0
Y2FzZXMva2VybmVsL3N5c2NhbGxzL3V0aW1lbnNhdC91dGltZW5zYXRfdGVzdHMuc2gJMjAxMC0w
NC0wMSAxNDoyMzoxMS4wMDAwMDAwMDAgKzA4MDAKKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNj
YWxscy91dGltZW5zYXQvdXRpbWVuc2F0X3Rlc3RzLnNoCTIwMTAtMDQtMjggMTQ6MjM6NDIuNTA1
NDIyMTUyICswODAwCkBAIC00Myw2ICs0MywyMyBAQAogICAgICBleGl0IDE7CiBmaQogCisjIFNp
bmNlIHNvbWUgYXV0b21hdGVkIHRlc3Rpbmcgc3lzdGVtcyBoYXZlIG5vIHR0eSB3aGlsZSB0ZXN0
aW5nLAorIyBjb21tZW50IHRoaXMgbGluZSBpbiAvZXRjL3N1ZG9lcnMgdG8gYXZvaWQgdGhlIGVy
cm9yIG1lc3NhZ2U6CisjIGBzdWRvOiBzb3JyeSwgeW91IG11c3QgaGF2ZSBhIHR0eSB0byBydW4g
c3VkbycKKyMgVXNlIHRyYXAgdG8gcmVzdG9yZSB0aGlzIGxpbmUgYWZ0ZXIgcHJvZ3JhbSB0ZXJt
aW5hdGVzLgorcGF0dGVybj0iW1s6c3BhY2U6XV0qRGVmYXVsdHNbWzpzcGFjZTpdXSpyZXF1aXJl
dHR5LioiCitpZiBncmVwIC1xICJeJHtwYXR0ZXJufSIgL2V0Yy9zdWRvZXJzOyB0aGVuCisJZWNo
byAiJHtURVNUX1BST0d9IDAgSU5GTyA6IENvbW1lbnQgcmVxdWlyZXR0eSBpbiAvZXRjL3N1ZG9l
cnMgZm9yIGF1dG9tYXRlZCB0ZXN0aW5nIHN5c3RlbXMiCisJc2VkIC1FIC1pIiIgLWUgInMvXigk
cGF0dGVybikvI1wxLyIgL2V0Yy9zdWRvZXJzCisJdHJhcCAndHJhcCAiIiBFWElUOyB0ZWFyZG93
bicgRVhJVAorZmkKKwordGVhcmRvd24oKQoreworCWVjaG8gIiR7VEVTVF9QUk9HfSAwIElORk8g
OiBSZXN0b3JlIHJlcXVpcmV0dHkgaW4gL2V0Yy9zdWRvZXJzIgorCXNlZCAtRSAtaSIiIC1lICJz
L14jKCRwYXR0ZXJuKS9cMS8iIC9ldGMvc3Vkb2VycworfQorCiAjIFN1bW1hcnkgY291bnRlcnMg
b2YgYWxsIHRlc3QgcmVzdWx0cwogCiB0ZXN0X251bT0wCg==
--00504502c13892382c0485461dd1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--00504502c13892382c0485461dd1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--00504502c13892382c0485461dd1--

