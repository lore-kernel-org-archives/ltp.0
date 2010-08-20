Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <godwin.gao@hotmail.com>) id 1OmMeI-0004m5-UJ
	for ltp-list@lists.sourceforge.net; Fri, 20 Aug 2010 08:08:26 +0000
Received: from snt0-omc1-s28.snt0.hotmail.com ([65.55.90.39])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OmMeG-00065K-JC
	for ltp-list@lists.sourceforge.net; Fri, 20 Aug 2010 08:08:26 +0000
Message-ID: <SNT119-W3821029ADE3BBEE190C837949F0@phx.gbl>
Content-Type: multipart/mixed;
	boundary="_f198921b-6306-4de6-bb47-fc841536cc46_"
From: GaoGodwin <godwin.gao@hotmail.com>
Date: Fri, 20 Aug 2010 16:08:18 +0800
MIME-Version: 1.0
Subject: [LTP] =?windows-1256?q?=5BPATCH=5Dfix_the_at=5Fdeny01_failure=FE?=
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
To: ltp-list@lists.sourceforge.net

--_f198921b-6306-4de6-bb47-fc841536cc46_
Content-Type: multipart/alternative;
	boundary="_b8bb5478-d312-42b6-a3f3-f86b033e9598_"

--_b8bb5478-d312-42b6-a3f3-f86b033e9598_
Content-Type: text/plain; charset="windows-1256"
Content-Transfer-Encoding: 8bit


Hi,


There are three failures found when running the LTP at_deny01 case.



[1] at_deny01    1  TCONF  :  at command not found on system

[2] /home/test_user_1/at_deny01: line 129: tst_resm: command not found

[3] You are required to change your password immediately (root enforced)



The root causes of these failures:



[1] In the shell script, if the return value of a function is 0, it view as TRUE. In the at_deny01

162 if type at > /dev/null; then

163         tst_resm TCONF "at command not found on system"

if the system has at function, shell script will print "at command not found on system". This is opposite.



[2] In the at_deny01, root user will create user named a test_user_1,
copy the file at_deny01 to the home directory of test_user_1,

change user to test_user_1 and run the at_deny01 script.

when run the script, ${LTPROOT}/testcase/bin is in the environment
variable of root, but NOT in the test_user_1. So when the test_user_1

run this script, it can NOT find the tst_resm command.



[3] When some boards boot up, the system time is
010100001970. the Linux system will let NON-root user change its password immediately 
and stop the script running. This patch will let the script run normally without changing the password. 



Patch attached, I have checked it on the Ubuntu.

Signed-off-by: Godwin Gao <godwin.gao@hotmail.com>



Best Regard

Godwin Gao 		 	   		  
--_b8bb5478-d312-42b6-a3f3-f86b033e9598_
Content-Type: text/html; charset="windows-1256"
Content-Transfer-Encoding: 8bit

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
font-size: 10pt;
font-family:????
}
--></style>
</head>
<body class='hmmessage'>
<font style="font-size: 10pt;" size="2">Hi,<br>
<br>There are three failures found when running the LTP at_deny01 case.<br>
<br>
[1] at_deny01&nbsp;&nbsp;&nbsp; 1&nbsp; TCONF&nbsp; :&nbsp; at command not found on system<br>
[2] /home/test_user_1/at_deny01: line 129: tst_resm: command not found<br>
[3] You are required to change your password immediately (root enforced)<br>
<br>
The root causes of these failures:<br>
<br>
[1] In the shell script, if the return value of a function is 0, it view as TRUE. In the at_deny01<br>
162 if type at &gt; /dev/null; then<br>
163&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tst_resm TCONF "at command not found on system"<br>
if the system has at function, shell script will print "at command not found on system". This is opposite.<br>
<br>
[2] In the at_deny01, root user will create user named a test_user_1,
copy the file at_deny01 to the home directory of test_user_1,<br>
change user to test_user_1 and run the at_deny01 script.<br>
when run the script, ${LTPROOT}/testcase/bin is in the environment
variable of root, but NOT in the test_user_1. So when the test_user_1<br>
run this script, it can NOT find the tst_resm command.<br>
<br>
[3] When some boards boot up, the system time is
010100001970. the Linux system will let NON-root user change its password immediately <br>and stop the script running. This patch will let the script run normally without changing the password. <br>
<br>
Patch attached, I have checked it on the Ubuntu.<br><br>Signed-off-by: Godwin Gao &lt;godwin.gao@hotmail.com&gt;<br>
<br>
Best Regard<br>
Godwin Gao</font> 		 	   		  </body>
</html>
--_b8bb5478-d312-42b6-a3f3-f86b033e9598_--

--_f198921b-6306-4de6-bb47-fc841536cc46_
Content-Type: text/x-diff
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0001-Fix-the-at_deny01.patch"

RnJvbSAwMTIyYjVkOTA3ZWMwZmE2ZDJiNzVkNDJlODk2N2RhMjNjMGIyNzI5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBHb2R3aW4gR2FvIDxnb2R3aW4uZ2FvQGhvdG1haWwuY29tPgpE
YXRlOiBGcmksIDIwIEF1ZyAyMDEwIDExOjI5OjQyICswODAwClN1YmplY3Q6IFtQQVRDSF0gRml4
IHRoZSBhdF9kZW55MDEKClRocmVlIGZhaWx1cmVzIGFyZSBmb3VuZCBpbiB0aGUgTFRQIGF0X2Rl
bnkwMS4KClsxXSBhdF9kZW55MDEgICAgMSAgVENPTkYgIDogIGF0IGNvbW1hbmQgbm90IGZvdW5k
IG9uIHN5c3RlbQpbMl0gL2hvbWUvdGVzdF91c2VyXzEvYXRfZGVueTAxOiBsaW5lIDEyOTogdHN0
X3Jlc206IGNvbW1hbmQgbm90IGZvdW5kClszXSBZb3UgYXJlIHJlcXVpcmVkIHRvIGNoYW5nZSB5
b3VyIHBhc3N3b3JkIGltbWVkaWF0ZWx5IChyb290IGVuZm9yY2VkKQoKVGhlIHJvb3QgY2F1c2Vz
IG9mIHRoZXNlIGZhaWx1cmVzOgoKWzFdIEluIHRoZSBzaGVsbCBzY3JpcHQsIGlmIHRoZSByZXR1
cm4gdmFsdWUgb2YgYSBmdW5jdGlvbiBpcyAwLCBpdCB2aWV3IGFzIFRSVUUuIEluIHRoZSBhdF9k
ZW55MDEKMTYyIGlmIHR5cGUgYXQgPiAvZGV2L251bGw7IHRoZW4KMTYzICAgICAgICAgdHN0X3Jl
c20gVENPTkYgImF0IGNvbW1hbmQgbm90IGZvdW5kIG9uIHN5c3RlbSIKaWYgdGhlIHN5c3RlbSBo
YXMgYXQgZnVuY3Rpb24sIHNoZWxsIHNjcmlwdCB3aWxsIHByaW50ICJhdCBjb21tYW5kIG5vdCBm
b3VuZCBvbiBzeXN0ZW0iLiBUaGlzIGlzIG9wcG9zaXRlLgoKWzJdIEluIHRoZSBhdF9kZW55MDEs
IHJvb3QgdXNlciB3aWxsIGNyZWF0ZSB1c2VyIG5hbWVkIGEgdGVzdF91c2VyXzEsICBjb3B5IHRo
ZSBmaWxlIGF0X2RlbnkwMSB0byB0aGUgaG9tZSBkaXJlY3Rvcnkgb2YgdGVzdF91c2VyXzEKY2hh
bmdlIHVzZXIgdG8gdGVzdF91c2VyXzEgYW5kIHJ1biB0aGUgYXRfZGVueTAxIHNjcmlwdC4Kd2hl
biBydW4gdGhlIHNjcmlwdCwgJHtMVFBST09UfS90ZXN0Y2FzZS9iaW4gaXMgaW4gdGhlIGVudmly
b25tZW50IHZhcmlhYmxlIG9mIHJvb3QsIGJ1dCBOT1QgaW4gdGhlIHRlc3RfdXNlcl8xLiBTbyB0
aGUgdGVzdF91c2VyXzEKcnVuIHRoaXMgc2NyaXB0LCBpdCBjYW4gTk9UIGZpbmQgdGhlIHRzdF9y
ZXNtIGNvbW1hbmQuCgpbM10gV2hlbiBzb21lIGJvYXJkcyBib290IHVwLCBpdHMgdGltZSBpcyAw
MTAxMDAwMDE5NzAuIHRoZSBMaW51eCBzeXN0ZW0gd2lsbCBsZXQgTk9OLXJvb3QgdXNlciBjaGFu
Z2UgaXRzIHBhc3N3b3JkIGltbWVkaWF0ZWx5CmFuZCBzdG9wIHRoZSBzY3JpcHQgcnVubmluZy4g
VGhpcyBwYXRjaCB3aWxsIGxldCB0aGUgc2NyaXB0IHJ1biBub3JtYWxseSB3aXRob3V0IGNoYW5n
aW5nIHRoZSBwYXNzd29yZC4KClNpZ25lZC1vZmYtYnk6IEdvZHdpbiBHYW8gPGdvZHdpbi5nYW9A
aG90bWFpbC5jb20+Ci0tLQogdGVzdGNhc2VzL2NvbW1hbmRzL2F0L2F0X2RlbnkwMSB8ICAgIDgg
KysrKystLS0KIDEgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9jb21tYW5kcy9hdC9hdF9kZW55MDEgYi90ZXN0Y2Fz
ZXMvY29tbWFuZHMvYXQvYXRfZGVueTAxCmluZGV4IGRjZWM2ODQuLjQyY2JiYjEgMTAwNzU1Ci0t
LSBhL3Rlc3RjYXNlcy9jb21tYW5kcy9hdC9hdF9kZW55MDEKKysrIGIvdGVzdGNhc2VzL2NvbW1h
bmRzL2F0L2F0X2RlbnkwMQpAQCAtNjQsMTIgKzY0LDE0IEBAIGRvX3NldHVwKCkKIAkJZWNobyAi
Q291bGQgbm90IGFkZCB0ZXN0IHVzZXIgJHt0ZXN0X3VzZXIxfSB0byBzeXN0ZW0uIgogCQlleGl0
IDEKIAlmaQorCWNoYWdlIC1kIDEwICR7dGVzdF91c2VyMX0KIAogCSMgQ3JlYXRlIHRoZSAybmQg
dXNlci4KIAlpZiAhIHVzZXJhZGQgLWcgdXNlcnMgLWQgIiR7dGVzdF91c2VyMl9ob21lfSIgLW0g
IiR7dGVzdF91c2VyMn0iOyB0aGVuCiAJCWVjaG8gIkNvdWxkIG5vdCBhZGQgdGVzdCB1c2VyICR7
dGVzdF91c2VyMn0gdG8gc3lzdGVtLiIKIAkJZXhpdCAxCiAJZmkKKwljaGFnZSAtZCAxMCAke3Rl
c3RfdXNlcjJ9CiAKIAkjIFRoaXMgaXMgdGhlIHdvcmthcm91bmQgZm9yIGEgcG90ZW50aWFsIGJ1
Zy4KIAkjIFtCdWcgNDY4MzM3XSBBdCBSZWZ1c2UgdG8gV29yayB3aXRoIE5vbi1sb2dpbiBTaGVs
bApAQCAtMTU3LDE1ICsxNTksMTUgQEAgcnVuX3Rlc3QoKQogIy0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiAjIEZV
TkNUSU9OOiBtYWluCiAjLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KLWlmIHR5cGUgYXQgPiAvZGV2L251bGw7IHRo
ZW4KK2lmICEgdHlwZSBhdCA+IC9kZXYvbnVsbDsgdGhlbgogCXRzdF9yZXNtIFRDT05GICJhdCBj
b21tYW5kIG5vdCBmb3VuZCBvbiBzeXN0ZW0iCiBlbGlmIFsgIiQoaWQgLXJ1KSIgPSAwIF07IHRo
ZW4KIAlpZiBkb19zZXR1cCA7IHRoZW4KIAkJaWYgISBlY2hvICIke3Rlc3RfdXNlcjJ9IiA+IiR7
ZGVueX0iOyB0aGVuCiAJCQlleGl0X2NvZGU9MQotCQllbGlmICEgc3UgIiR7dGVzdF91c2VyMX0i
IC1sYyAiJHt0ZXN0X3VzZXIxX2hvbWV9LyR7MCMjKi99IjsgdGhlbgorCQllbGlmICEgc3UgIiR7
dGVzdF91c2VyMX0iIC1wbGMgIiR7dGVzdF91c2VyMV9ob21lfS8kezAjIyovfSI7IHRoZW4KIAkJ
CWV4aXRfY29kZT0xCi0JCWVsaWYgISBzdSAiJHt0ZXN0X3VzZXIyfSIgLWxjICIke3Rlc3RfdXNl
cjJfaG9tZX0vJHswIyMqL30iOyB0aGVuCisJCWVsaWYgISBzdSAiJHt0ZXN0X3VzZXIyfSIgLXBs
YyAiJHt0ZXN0X3VzZXIyX2hvbWV9LyR7MCMjKi99IjsgdGhlbgogCQkJZXhpdF9jb2RlPTEKIAkJ
ZWxzZQogCQkJZXhpdF9jb2RlPTAKLS0gCjEuNS42LjMKCg==

--_f198921b-6306-4de6-bb47-fc841536cc46_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by 

Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev 
--_f198921b-6306-4de6-bb47-fc841536cc46_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--_f198921b-6306-4de6-bb47-fc841536cc46_--

