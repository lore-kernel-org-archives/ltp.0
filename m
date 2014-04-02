Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <eeslook@163.com>) id 1WV9ud-0003qD-Oc
	for ltp-list@lists.sourceforge.net; Wed, 02 Apr 2014 01:24:19 +0000
Received: from m13-64.163.com ([220.181.13.64])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WV9uW-0003QP-2c
	for ltp-list@lists.sourceforge.net; Wed, 02 Apr 2014 01:24:19 +0000
Date: Wed, 2 Apr 2014 09:24:00 +0800 (CST)
From: =?GBK?B?wO6//A==?= <eeslook@163.com>
Content-Type: multipart/mixed; 
	boundary="----=_Part_328055_1644103330.1396401840704"
MIME-Version: 1.0
Message-ID: <19a2d985.16036.14520092241.Coremail.eeslook@163.com>
Subject: [LTP] Fw:Re: [ltp] ltp / testscripts / ltpstress.sh #line 257 :
 error command format for sar (#10)
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

------=_Part_328055_1644103330.1396401840704
Content-Type: multipart/alternative; 
	boundary="----=_Part_328057_1088804565.1396401840705"

------=_Part_328057_1088804565.1396401840705
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: base64

SGksICAgCiAgICBBdHRhY2ggdGhlIHBhdGNoIGZpbGUgZm9yIGZpeCBzYXIgY29tbWFuZCBlcnJv
ci4KCgotLS0tLS0tLSDXqrei08q8/tDFz6IgLS0tLS0tLS0Kt6K8/sjLo7oiQ3lyaWwgSHJ1Ymlz
IiA8bm90aWZpY2F0aW9uc0BnaXRodWIuY29tPgq3osvNyNXG2qO6MjAxNC0wNC0wMSAyMToyMzoz
MwrK1bz+yMujumxpbnV4LXRlc3QtcHJvamVjdC9sdHAgPGx0cEBub3JlcGx5LmdpdGh1Yi5jb20+
CrOty83Iy6O6bG9vayA8ZWVzbG9va0AxNjMuY29tPgrW98zio7pSZTogW2x0cF0gIGx0cCAvIHRl
c3RzY3JpcHRzIC8gbHRwc3RyZXNzLnNoICNsaW5lIDI1NyA6IGVycm9yIGNvbW1hbmQgZm9ybWF0
IGZvciBzYXIgICgjMTApCgoKQ2FuIHlvdSBwbGVhc2Ugc2VuZCBhIHBhdGNoIHRvIHRoZSBMVFAg
bWFpbGluZyBsaXN0PwoKoaoKUmVwbHkgdG8gdGhpcyBlbWFpbCBkaXJlY3RseSBvciB2aWV3IGl0
IG9uIEdpdEh1Yi4=
------=_Part_328057_1088804565.1396401840705
Content-Type: text/html; charset=GBK
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0ibGluZS1oZWlnaHQ6MS43O2NvbG9yOiMwMDAwMDA7Zm9udC1zaXplOjE0cHg7
Zm9udC1mYW1pbHk6YXJpYWwiPkhpLCAmbmJzcDsmbmJzcDs8ZGl2PiZuYnNwOyAmbmJzcDsgQXR0
YWNoIHRoZSBwYXRjaCBmaWxlIGZvciBmaXggc2FyIGNvbW1hbmQgZXJyb3IuPC9kaXY+PGRpdj48
YnI+PC9kaXY+PGRpdiBpZD0iaXNGb3J3YXJkQ29udGVudCI+LS0tLS0tLS0g16q3otPKvP7Qxc+i
IC0tLS0tLS0tPGJyPreivP7Iy6O6IkN5cmlsIEhydWJpcyIgJmx0O25vdGlmaWNhdGlvbnNAZ2l0
aHViLmNvbSZndDs8YnI+t6LLzcjVxtqjujIwMTQtMDQtMDEgMjE6MjM6MzM8YnI+ytW8/sjLo7ps
aW51eC10ZXN0LXByb2plY3QvbHRwICZsdDtsdHBAbm9yZXBseS5naXRodWIuY29tJmd0Ozxicj6z
rcvNyMujumxvb2sgJmx0O2Vlc2xvb2tAMTYzLmNvbSZndDs8YnI+1vfM4qO6UmU6Jm5ic3A7W2x0
cF0mbmJzcDsmbmJzcDtsdHAmbmJzcDsvJm5ic3A7dGVzdHNjcmlwdHMmbmJzcDsvJm5ic3A7bHRw
c3RyZXNzLnNoJm5ic3A7I2xpbmUmbmJzcDsyNTcmbmJzcDs6Jm5ic3A7ZXJyb3ImbmJzcDtjb21t
YW5kJm5ic3A7Zm9ybWF0Jm5ic3A7Zm9yJm5ic3A7c2FyJm5ic3A7Jm5ic3A7KCMxMCk8YnI+PHA+
Q2FuIHlvdSBwbGVhc2Ugc2VuZCBhIHBhdGNoIHRvIHRoZSBMVFAgbWFpbGluZyBsaXN0PzwvcD4K
CjxwIHN0eWxlPSJmb250LXNpemU6c21hbGw7LXdlYmtpdC10ZXh0LXNpemUtYWRqdXN0Om5vbmU7
Y29sb3I6IzY2NjsiPqGqPGJyPlJlcGx5IHRvIHRoaXMgZW1haWwgZGlyZWN0bHkgb3IgPGEgaHJl
Zj0iaHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LXRlc3QtcHJvamVjdC9sdHAvaXNzdWVzLzEwI2lz
c3VlY29tbWVudC0zOTIwNDIxMCI+dmlldyBpdCBvbiBHaXRIdWI8L2E+LjxpbWcgc3JjPSJodHRw
czovL2dpdGh1Yi5jb20vbm90aWZpY2F0aW9ucy9iZWFjb24vNDA0Mzg3MV9fZXlKelkyOXdaU0k2
SWs1bGQzTnBaWE02UW1WaFkyOXVJaXdpWlhod2FYSmxjeUk2TVRjeE1UazNOemd4TXl3aVpHRjBZ
U0k2ZXlKcFpDSTZNamc1TmpJMk5EbDlmUT09LS0xNjVhNzBlYTE2ZjcwOTQzMmNjNWQ3OTkzOTZl
ZWMzNDI2MzZiNmNkLmdpZiIgaGVpZ2h0PSIxIiB3aWR0aD0iMSI+PC9wPjwvZGl2PjwvZGl2Pjxi
cj48YnI+PHNwYW4gdGl0bGU9Im5ldGVhc2Vmb290ZXIiPjxzcGFuIGlkPSJuZXRlYXNlX21haWxf
Zm9vdGVyIj48L3NwYW4+PC9zcGFuPg==
------=_Part_328057_1088804565.1396401840705--

------=_Part_328055_1644103330.1396401840704
Content-Type: application/octet-stream;
	name="ltp-fix-sar-commanderr-20140401.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="ltp-fix-sar-commanderr-20140401.patch"

ZGlmZiAtcnVwTiBsdHAtMjAxNDAxMTUvdGVzdHNjcmlwdHMvbHRwc3RyZXNzLnNoIGx0cC0yMDE0
MDExNS1zYXIvdGVzdHNjcmlwdHMvbHRwc3RyZXNzLnNoCi0tLSBsdHAtMjAxNDAxMTUvdGVzdHNj
cmlwdHMvbHRwc3RyZXNzLnNoCTIwMTQtMDEtMTYgMDE6MjY6MjkuMDAwMDAwMDAwICswODAwCisr
KyBsdHAtMjAxNDAxMTUtc2FyL3Rlc3RzY3JpcHRzL2x0cHN0cmVzcy5zaAkyMDE0LTA0LTAxIDEw
OjE3OjE2LjgxNDgyMDcwMCArMDgwMApAQCAtMjU0LDcgKzI1NCw3IEBAICR7TFRQUk9PVH0vYmlu
L3JhbmRfbGluZXMgLWcgJHtMVFBST09UfS8KIHNsZWVwIDIKIAogaWYgWyAkU2FyIC1lcSAxIF07
IHRoZW4KLSAgc2FyIC1vICRkYXRhZmlsZSAkaW50ZXJ2YWwgMCAmCisgIHNhciAtbyAkZGF0YWZp
bGUgJGludGVydmFsICYKIGZpCiAKIGlmIFsgJFRvcCAtZXEgMSBdOyB0aGVuCg==
------=_Part_328055_1644103330.1396401840704
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

------=_Part_328055_1644103330.1396401840704
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_328055_1644103330.1396401840704--


