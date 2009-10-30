Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1N3q0j-0006ct-19
	for ltp-list@lists.sourceforge.net; Fri, 30 Oct 2009 11:51:17 +0000
Received: from fmmailgate03.web.de ([217.72.192.234])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N3q0c-00062X-Cf
	for ltp-list@lists.sourceforge.net; Fri, 30 Oct 2009 11:51:16 +0000
Date: Fri, 30 Oct 2009 13:53:09 +0100
From: =?iso-8859-2?B?Smn47SBQYWxl6GVr?= <jpalecek@web.de>
Content-Type: multipart/mixed; boundary=----------FPJCwC77vNdNT8j4mUP0Vj
MIME-Version: 1.0
References: <200910211528.n9LFST8q028289@e35.co.us.ibm.com>
	<1256576544.4929.54.camel@subratamodak.linux.ibm.com>
	<loom.20091029T190532-79@post.gmane.org>
	<1256902668.13702.2.camel@subratamodak.linux.ibm.com>
Message-ID: <op.u2l52sjuu2flwt@debian>
In-Reply-To: <1256902668.13702.2.camel@subratamodak.linux.ibm.com>
Subject: Re: [LTP] [PATCH] Fix some bashisms
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
To: subrata@linux.vnet.ibm.com
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

------------FPJCwC77vNdNT8j4mUP0Vj
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-2
Content-Transfer-Encoding: quoted-printable

On Fri, 30 Oct 2009 12:37:48 +0100, Subrata Modak =20
<subrata@linux.vnet.ibm.com> wrote:

> On Thu, 2009-10-29 at 18:12 +0000, Ji=F8=EDPale=E8ek wrote:
>> Hello,
>>
>> Subrata Modak <subrata@...> writes:
>>
>> >
>> > On Wed, 2009-10-21 at 02:19 +0200, Jiri Palecek wrote:
>> > > Hello,
>> > >
>> > > this is another patch fixing bashisms in LTP tests (the fixes are =
=20
>> more or
>> less the same as in the previous
>> > patches, except for a few exceptions). Note that the patch is not =20
>> complete,
>> in the sense that there may
>> > remain further bashisms in the source even after applying the patch =
=20
>> (like use
>> of arrays, which is visible
>> > even from this patch).
>> > >
>> > > Regards
>> > >     Jiri Palecek
>> > >
>> > > Signed-off-by: Jiri Palecek <jpalecek@...>
>> >
>> > Hmm,. Some of them failed to apply. Can you please resend only the =20
>> error
>> > part(s):
>> >
>>
>> according to my git repository. these are the missing parts:
>>
>> Signed-off-by: Jiri Palecek <jpalecek@web.de>
>
> Then something wrong with my CVS:
>
> patching file testcases/kernel/fs/fs-bench/modaltr.sh
> Hunk #1 FAILED at 43.
> 1 out of 1 hunk FAILED -- saving rejects to file
> testcases/kernel/fs/fs-bench/modaltr.sh.rej
> patching file testcases/kernel/fs/mongo/test.sh
> Hunk #1 FAILED at 26.
> Hunk #2 FAILED at 52.
> Hunk #3 FAILED at 70.
> 3 out of 3 hunks FAILED -- saving rejects to file
> testcases/kernel/fs/mongo/test.sh.rej
> patching file testcases/network/tcp_cmds/netstat/netstat01
>
> Can you please verify ?

It works for me in CVS, so I guess it was just a linewrap, whitespace or =
=20
something issue. See attachment for the original (uncrippled) patch.

Regards
     Jiri Palecek

>> ---
>>  testcases/kernel/fs/fs-bench/modaltr.sh      |    2 +-
>>  testcases/kernel/fs/mongo/test.sh            |    8 +++-----
>>  testcases/network/tcp_cmds/netstat/netstat01 |    2 +-
>>  3 files changed, 5 insertions(+), 7 deletions(-)
>>
>> diff --git a/testcases/kernel/fs/fs-bench/modaltr.sh =20
>> b/testcases/kernel/fs/fs-
>> bench/modaltr.sh
>> index 85d2c30..36e6f0c 100755
>> --- a/testcases/kernel/fs/fs-bench/modaltr.sh
>> +++ b/testcases/kernel/fs/fs-bench/modaltr.sh
>> @@ -43,7 +43,7 @@ LOG_DIR1=3D/tmp/log1
>>  HOME_DIR=3D/home
>>  BLOCK_DIR=3D/dev/mtdblock
>>  export PATH=3D$PATH:/sbin
>> -	if [ $UID -ne 0 ];
>> +	if [ $(id -ru) -ne 0 ];
>>  then
>>  	echo "must be root to run this"
>>  	exit
>> diff --git a/testcases/kernel/fs/mongo/test.sh =20
>> b/testcases/kernel/fs/mongo/
>> test.sh
>> index fe75664..eccb079 100755
>> --- a/testcases/kernel/fs/mongo/test.sh
>> +++ b/testcases/kernel/fs/mongo/test.sh
>> @@ -26,7 +26,7 @@ TEST_DIR=3Dtestdir
>>
>>
>>     		#should be root  to execute this script .
>> -	if [ $UID -ne 0 ]; then
>> +	if [ $(id -ru) -ne 0 ]; then
>>  		echo "This script must be run as root"
>>  		exit
>>  	fi
>> @@ -52,8 +52,7 @@ modprobe loop
>>  	fi
>>
>>  	#run the mongo test on reiserfs file system type
>> -function reiserfs
>> -
>> +reiserfs()
>>  {
>>  cat > fs.sh <<EOF
>>  echo "performing mongo on reiserfs"
>> @@ -71,8 +70,7 @@ EOF
>>  =09
>>
>>  #To run on jfs file system type
>> -function  JFS
>> -
>> +JFS()
>>  {
>>  cat >> fs.sh <<EOF
>>  echo "performing mongo on jfs file system"
>> diff --git a/testcases/network/tcp_cmds/netstat/netstat01 =20
>> b/testcases/network/
>> tcp_cmds/netstat/netstat01
>> index 6a197de..365c142 100755
>> --- a/testcases/network/tcp_cmds/netstat/netstat01
>> +++ b/testcases/network/tcp_cmds/netstat/netstat01
>> @@ -58,7 +58,7 @@ do_test() {
>>      while [ $TST_COUNT -le $NUMLOOPS ]; do
>>
>>          for flag in "-s" "-rn" "-i" "-gn" "-apn"; do
>> -            if ! netstat $flag 2>&1 1>/dev/null; then
>> +            if ! netstat $flag 1>/dev/null 2>&1; then
>>                  end_testcase "$COMMAND failed"
>>              fi
>>          done
>



--=20
Using Opera's revolutionary e-mail client: http://www.opera.com/mail/
------------FPJCwC77vNdNT8j4mUP0Vj
Content-Disposition: attachment; filename=0001-Fix-some-bashisms.patch
Content-Type: application/octet-stream; name=0001-Fix-some-bashisms.patch
Content-Transfer-Encoding: Base64

RnJvbSA4YmEwMDNkYmM4MGYwMjgwZjFkNjhiZjUxMjMyOWRkYmUxYTA3ZGQwIE1v
biBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKaXJpIFBhbGVjZWsgPGpwYWxl
Y2VrQHdlYi5kZT4KRGF0ZTogV2VkLCAyMSBPY3QgMjAwOSAwMjoxOTo1OCArMDIw
MApTdWJqZWN0OiBbUEFUQ0hdIEZpeCBzb21lIGJhc2hpc21zCgotLS0KIHRlc3Rj
YXNlcy9rZXJuZWwvZnMvZnMtYmVuY2gvbW9kYWx0ci5zaCAgICAgIHwgICAgMiAr
LQogdGVzdGNhc2VzL2tlcm5lbC9mcy9tb25nby90ZXN0LnNoICAgICAgICAgICAg
fCAgICA4ICsrKy0tLS0tCiB0ZXN0Y2FzZXMvbmV0d29yay90Y3BfY21kcy9uZXRz
dGF0L25ldHN0YXQwMSB8ICAgIDIgKy0KIDMgZmlsZXMgY2hhbmdlZCwgNSBpbnNl
cnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Rlc3RjYXNl
cy9rZXJuZWwvZnMvZnMtYmVuY2gvbW9kYWx0ci5zaCBiL3Rlc3RjYXNlcy9rZXJu
ZWwvZnMvZnMtYmVuY2gvbW9kYWx0ci5zaAppbmRleCA4NWQyYzMwLi4zNmU2ZjBj
IDEwMDc1NQotLS0gYS90ZXN0Y2FzZXMva2VybmVsL2ZzL2ZzLWJlbmNoL21vZGFs
dHIuc2gKKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9mcy9mcy1iZW5jaC9tb2RhbHRy
LnNoCkBAIC00Myw3ICs0Myw3IEBAIExPR19ESVIxPS90bXAvbG9nMQogSE9NRV9E
SVI9L2hvbWUNCiBCTE9DS19ESVI9L2Rldi9tdGRibG9jaw0KIGV4cG9ydCBQQVRI
PSRQQVRIOi9zYmluDQotCWlmIFsgJFVJRCAtbmUgMCBdOyANCisJaWYgWyAkKGlk
IC1ydSkgLW5lIDAgXTsgDQogdGhlbiANCiAJZWNobyAibXVzdCBiZSByb290IHRv
IHJ1biB0aGlzIg0KIAlleGl0DQpkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5l
bC9mcy9tb25nby90ZXN0LnNoIGIvdGVzdGNhc2VzL2tlcm5lbC9mcy9tb25nby90
ZXN0LnNoCmluZGV4IGZlNzU2NjQuLmVjY2IwNzkgMTAwNzU1Ci0tLSBhL3Rlc3Rj
YXNlcy9rZXJuZWwvZnMvbW9uZ28vdGVzdC5zaAorKysgYi90ZXN0Y2FzZXMva2Vy
bmVsL2ZzL21vbmdvL3Rlc3Quc2gKQEAgLTI2LDcgKzI2LDcgQEAgVEVTVF9ESVI9
dGVzdGRpcgogDQogDQogICAgCQkjc2hvdWxkIGJlIHJvb3QgIHRvIGV4ZWN1dGUg
dGhpcyBzY3JpcHQgLg0KLQlpZiBbICRVSUQgLW5lIDAgXTsgdGhlbg0KKwlpZiBb
ICQoaWQgLXJ1KSAtbmUgMCBdOyB0aGVuDQogCQllY2hvICJUaGlzIHNjcmlwdCBt
dXN0IGJlIHJ1biBhcyByb290Ig0KIAkJZXhpdA0KIAlmaQ0KQEAgLTUyLDggKzUy
LDcgQEAgbW9kcHJvYmUgbG9vcAogCWZpDQogDQogCSNydW4gdGhlIG1vbmdvIHRl
c3Qgb24gcmVpc2VyZnMgZmlsZSBzeXN0ZW0gdHlwZSANCi1mdW5jdGlvbiByZWlz
ZXJmcw0KLQ0KK3JlaXNlcmZzKCkNCiB7DQogY2F0ID4gZnMuc2ggPDxFT0YNCiBl
Y2hvICJwZXJmb3JtaW5nIG1vbmdvIG9uIHJlaXNlcmZzIg0KQEAgLTcxLDggKzcw
LDcgQEAgRU9GCiAJDQogDQogI1RvIHJ1biBvbiBqZnMgZmlsZSBzeXN0ZW0gdHlw
ZSANCi1mdW5jdGlvbiAgSkZTDQotDQorSkZTKCkNCiB7DQogY2F0ID4+IGZzLnNo
IDw8RU9GDQogZWNobyAicGVyZm9ybWluZyBtb25nbyBvbiBqZnMgZmlsZSBzeXN0
ZW0iDQpkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL25ldHdvcmsvdGNwX2NtZHMvbmV0
c3RhdC9uZXRzdGF0MDEgYi90ZXN0Y2FzZXMvbmV0d29yay90Y3BfY21kcy9uZXRz
dGF0L25ldHN0YXQwMQppbmRleCA2YTE5N2RlLi4zNjVjMTQyIDEwMDc1NQotLS0g
YS90ZXN0Y2FzZXMvbmV0d29yay90Y3BfY21kcy9uZXRzdGF0L25ldHN0YXQwMQor
KysgYi90ZXN0Y2FzZXMvbmV0d29yay90Y3BfY21kcy9uZXRzdGF0L25ldHN0YXQw
MQpAQCAtNTgsNyArNTgsNyBAQCBkb190ZXN0KCkgewogICAgIHdoaWxlIFsgJFRT
VF9DT1VOVCAtbGUgJE5VTUxPT1BTIF07IGRvCiAKICAgICAgICAgZm9yIGZsYWcg
aW4gIi1zIiAiLXJuIiAiLWkiICItZ24iICItYXBuIjsgZG8KLSAgICAgICAgICAg
IGlmICEgbmV0c3RhdCAkZmxhZyAyPiYxIDE+L2Rldi9udWxsOyB0aGVuCisgICAg
ICAgICAgICBpZiAhIG5ldHN0YXQgJGZsYWcgMT4vZGV2L251bGwgMj4mMTsgdGhl
bgogICAgICAgICAgICAgICAgIGVuZF90ZXN0Y2FzZSAiJENPTU1BTkQgZmFpbGVk
IgogICAgICAgICAgICAgZmkKICAgICAgICAgZG9uZQotLSAKMS42LjQuMwoK

------------FPJCwC77vNdNT8j4mUP0Vj
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
------------FPJCwC77vNdNT8j4mUP0Vj
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------------FPJCwC77vNdNT8j4mUP0Vj--


