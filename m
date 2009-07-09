Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MOx9o-00005m-S3
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2009 17:11:40 +0000
Received: from mail-yx0-f195.google.com ([209.85.210.195])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MOx9k-0000ot-Is
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2009 17:11:40 +0000
Received: by yxe33 with SMTP id 33so465606yxe.28
	for <ltp-list@lists.sourceforge.net>;
	Thu, 09 Jul 2009 10:11:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4A55C646.5060805@petalogix.com>
References: <4A5436D4.6070201@petalogix.com>
	<364299f40907080719q4ab01842v7e47a352b8214b8a@mail.gmail.com>
	<4A54AEFA.3030100@petalogix.com>
	<364299f40907082230m27683f17yd042bd569d0a5165@mail.gmail.com>
	<4A55C646.5060805@petalogix.com>
Date: Thu, 9 Jul 2009 10:11:36 -0700
Message-ID: <364299f40907091011y2f988746n562e183b5d4276be@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Content-Type: multipart/mixed; boundary=00163698966fc0eb08046e48f27e
Subject: Re: [LTP] IDcheck.sh - awk problem
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
To: michal.simek@petalogix.com
Cc: LTP <ltp-list@lists.sourceforge.net>, Mike Frysinger <vapier.adi@gmail.com>

--00163698966fc0eb08046e48f27e
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2009 at 3:28 AM, Michal Simek<michal.simek@petalogix.com> wr=
ote:
> Garrett Cooper wrote:
>> On Wed, Jul 8, 2009 at 7:36 AM, Michal Simek<michal.simek@petalogix.com>=
 wrote:
>>
>>> Of course not because I cross compile ltp for Microblaze - correct
>>> /etc/passwd - group is on
>>> target system. Maybe worth to remove calling IDcheck.sh from make
>>> install and call it only before
>>> running the test.
>>>
>>>
>>
>> Michal,
>> =A0 =A0 Please give this patch a try, and instead when you run make
>> install, do SKIP_IDCHECK=3D1.
>> HTH,
>> -Garrett

Wow. I must have been tired at the time; no idea why I used filter
instead of strip. Please try this instead.

Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

--00163698966fc0eb08046e48f27e
Content-Type: application/octet-stream; name="IDcheck_awk_fix+skip_check.diff"
Content-Disposition: attachment; filename="IDcheck_awk_fix+skip_check.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fwxqfvc80

SW5kZXg6IElEY2hlY2suc2gKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PQpSQ1MgZmlsZTogL2N2c3Jvb3QvbHRwL2x0cC9J
RGNoZWNrLnNoLHYKcmV0cmlldmluZyByZXZpc2lvbiAxLjE5CmRpZmYgLXUgLXIxLjE5IElEY2hl
Y2suc2gKLS0tIElEY2hlY2suc2gJNyBKdWwgMjAwOSAxNDozMDoyNyAtMDAwMAkxLjE5CisrKyBJ
RGNoZWNrLnNoCTkgSnVsIDIwMDkgMTc6MDc6MzYgLTAwMDAKQEAgLTIyLDcgKzIyLDYgQEAKICMK
IAogIyBQcm9tcHQgdXNlciBpZiBpZHMvZ3JvdXBzIHNob3VsZCBiZSBjcmVhdGVkCi1jbGVhcgog
ZWNobyAiQ2hlY2tpbmcgZm9yIHJlcXVpcmVkIHVzZXIvZ3JvdXAgaWRzIgogZWNobyAiIgogCkBA
IC00MSwxMiArNDAsMTEgQEAKIAogIyBmaW5kIGVudHJ5LgogZmUoKSB7Ci0JSUQ9JDE7IHNoaWZ0
Ci0JRklMRT0kMTsgc2hpZnQKLQlhd2sgIi9eJElEOi8geyBGT1VORD0xIH0gRU5EIHsgaWYgKFwk
Rk9VTkQgPT0gMSkgeyBleGl0IDA7IH0gZXhpdCAxOyB9IiBcCi0JIiRGSUxFIgotCWVjPSQ/Ci0J
ZWNobyAiJElEID0+ICRlYyIKKyAgICBJRD0kMTsgc2hpZnQKKyAgICBGSUxFPSQxOyBzaGlmdAor
ICAgIFsgLWUgIiRGSUxFIiBdIHx8IHJldHVybiAkPworICAgIGF3ayAiL14kSUQ6LyB7IEZPVU5E
PTEgfSBFTkQgeyBpZiAoXCRGT1VORCA9PSAxKSB7IGV4aXQgMTsgfSBleGl0IDA7IH0iIFwKKyAg
ICAiJEZJTEUiCiB9CiAKIHByb21wdF9mb3JfY3JlYXRlKCkgewpAQCAtNzAsMTMgKzY4LDEyIEBA
CiAJRVVJRD0kKGlkIC11KQogZmkKIAotaWYgWyAtZSAiJHBhc3N3ZCIgLWEgISAtciAiJHBhc3N3
ZCIgXSA7IHRoZW4KLQllY2hvICIvZXRjL3Bhc3N3ZCBub3QgcmVhZGFibGUgYnkgdWlkICRFVUlE
IgorZm9yIGkgaW4gIiRwYXNzd2QiICIkZ3JvdXAiOyBkbworICAgIGlmIFsgLWUgIiRpIiAtYSAh
IC1yICIkaSIgXSA7IHRoZW4KKwllY2hvICIkaSBub3QgcmVhZGFibGUgYnkgdWlkICRFVUlEIgog
CWV4aXQgMQotZWxpZiBbIC1lICIkZ3JvdXAiIC1hICEgLXIgIiRncm91cCIgXSA7IHRoZW4KLQll
Y2hvICIkZ3JvdXAgbm90IHJlYWRhYmxlIGJ5IHVpZCAkRVVJRCIKLQlleGl0IDEKLWZpCisgICAg
ZmkKK2RvbmUKIAogZmUgYmluICIkcGFzc3dkIjsgTk9fQklOX0lEPSQ/CiBmZSBkYWVtb24gIiRw
YXNzd2QiOyBOT19EQUVNT05fSUQ9JD8KQEAgLTExMCwxMCArMTA3LDEwIEBACiAjZGVidWdfdmFs
cwogCiBpZiBbICRDUkVBVEVfRU5UUklFUyAtbmUgMCBdIDsgdGhlbgotCWlmICEgdG91Y2ggIiRn
cm91cCIgOyB0aGVuCi0JCWVjaG8gIkNvdWxkbid0IHRvdWNoICRncm91cCIKLQkJZXhpdCAxCi0J
ZmkKKyAgICBpZiAhIHRvdWNoICIkZ3JvdXAiICIkcGFzc3dkIiAyPi9kZXYvbnVsbDsgdGhlbgor
ICAgICAgICBlY2hvICJGYWlsZWQgdG8gdG91Y2ggJGdyb3VwIG9yICRwYXNzd2QiCisgICAgICAg
IGV4aXQgMQorICAgIGZpCiBmaQogCiBtYWtlX3VzZXJfZ3JvdXAoKSB7CkluZGV4OiBNYWtlZmls
ZQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09ClJDUyBmaWxlOiAvY3Zzcm9vdC9sdHAvbHRwL01ha2VmaWxlLHYKcmV0cmll
dmluZyByZXZpc2lvbiAxLjM5CmRpZmYgLXUgLXIxLjM5IE1ha2VmaWxlCi0tLSBNYWtlZmlsZQky
NSBNYXIgMjAwOSAwNjoxNzo0OCAtMDAwMAkxLjM5CisrKyBNYWtlZmlsZQk5IEp1bCAyMDA5IDE3
OjA3OjM2IC0wMDAwCkBAIC0xNCw2ICsxNCwxMCBAQAogZXhwb3J0IENGTEFHUyArPSAtV2FsbCAk
KENST1NTX0NGTEFHUykKIGV4cG9ydCBDQyBBUiBSQU5MSUIgQ1BQRkxBR1MgTERGTEFHUyBIQVNf
TlVNQQogCisjIFNLSVBfSURDSEVDSwkhPSAxLCBkZWZhdWx0cyB0byBwcmV2aW91cyBiZWhhdmlv
ciwgd2hpY2ggaXMgdG8gZXhlY3V0ZQorIyBJRGNoZWNrLnNoIGF0IHRoZSBlbmQgb2YgYG1ha2Ug
aW5zdGFsbCcuCitTS0lQX0lEQ0hFQ0sJCT89IDAgCisKIC1pbmNsdWRlIGNvbmZpZy5tawogCiBW
UEFUSCArPSBpbmNsdWRlIG00CkBAIC0zNiw4ICs0MCw5IEBACiAJQCQoTUFLRSkgLUMgbTQgaW5z
dGFsbAogCUAkKE1BS0UpIC1DIGRvYy9tYW4xIGluc3RhbGwKIAlAJChNQUtFKSAtQyBkb2MvbWFu
MyBpbnN0YWxsCi0KK2lmbmVxICgkKHN0cmlwICQoU0tJUF9JRENIRUNLKSksMSkKIAlALi9JRGNo
ZWNrLnNoCitlbmRpZgogCiBsaWJsdHAuYTogY29uZmlnLmgKIAlAJChNQUtFKSAtQyBsaWIgJEAK
QEAgLTU0LDcgKzU5LDkgQEAKIHVjbGludXhfaW5zdGFsbDogdWNsaW51eAogCUAkKE1BS0UpIC1D
IHRlc3RjYXNlcyB1Y2xpbnV4X2luc3RhbGwKIAlAJChNQUtFKSAtQyB0b29scyBpbnN0YWxsCitp
Zm5lcSAoJChzdHJpcCAkKFNLSVBfSURDSEVDSykpLDEpCiAJQC4vSURjaGVjay5zaAorZW5kaWYK
IAogdWNsaW51eF9saWJsdHAuYToKIAlAJChNQUtFKSAtQyBsaWIgVUNMSU5VWD0xIGxpYmx0cC5h
Cg==
--00163698966fc0eb08046e48f27e
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
--00163698966fc0eb08046e48f27e
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--00163698966fc0eb08046e48f27e--

