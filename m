Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <skrishnakar@gmail.com>) id 1MTEID-0006ge-LM
	for Ltp-list@lists.sourceforge.net; Tue, 21 Jul 2009 12:18:01 +0000
Received: from mail-pz0-f201.google.com ([209.85.222.201])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MTEI6-0008Qr-Py
	for Ltp-list@lists.sourceforge.net; Tue, 21 Jul 2009 12:18:01 +0000
Received: by pzk39 with SMTP id 39so649023pzk.28
	for <Ltp-list@lists.sourceforge.net>;
	Tue, 21 Jul 2009 05:17:15 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 21 Jul 2009 17:47:15 +0530
Message-ID: <6213bc560907210517k1ec4279dr6fe1e7677bd9e20e@mail.gmail.com>
From: srikanth krishnakar <skrishnakar@gmail.com>
Subject: [LTP] msgctl10 fails on Powerpc Linux-2.6.29.6 (ppc440)
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3133113188918386670=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Nadia.Derbey@bull.net
Cc: Ltp-list@lists.sourceforge.net

--===============3133113188918386670==
Content-Type: multipart/alternative; boundary=001636e0a826329971046f363cee

--001636e0a826329971046f363cee
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

The LTP test case *msgctl10.c* fails on linux-2.6.29.6 for PowerPC
architecture (ppc440) Crashes the kernel with following trace


msgctl10    1  B------------[ cut here
]------------

kernel BUG at
arch/powerpc/kernel/traps.c:904!

Oops: Exception in kernel mode, sig: 5
[#9]

PREEMPT LTT NESTING LEVEL :
0

Virtex440

Modules linked
in:

NIP: c038178c LR: c0381640 CTR:
c02650bc

REGS: cafbbe70 TRAP: 0700   Tainted: G      D
(2.6.29.6)

MSR: 00029000 <EE,ME,CE>  CR: 48004224  XER:
20000008

TASK = cafa17f0[6435] 'msgctl10' THREAD:
cafba000

GPR00: 00000001 cafbbf20 cafa17f0 ffffffda 08000000 00000001 00000037
ffffffff
GPR08: cafa17f0 c04a0000 00021002 c0381594 28004222 1001f4bc bf93d950
100b0000
GPR16: 00000007 bf93d95c 100012a0 10005b84 00000067 100174e8 10017500
100174f8
GPR24: 00000000 00000001 103eaa50 00000000 00000000 00000000 08000000
cafbbf50
NIP [c038178c]
program_check_exception+0x1f8/0x5f4

LR [c0381640]
program_check_exception+0xac/0x5f4

Call
Trace:

[cafbbf20] [c0381640] program_check_exception+0xac/0x5f4
(unreliable)
[cafbbf40] [c000e78c]
ret_from_except_full+0x0/0x4c

Instruction
dump:

7d808120 4bc8ac20 2f830001 41beff38 2f83fff2 419e0024 77c00804
4182004c
3d20c04a 8809207c 2f800000 419e0080 <0fe00000> 48000000 80010024
3ca00003
---[ end trace fd0893c7d8cee1bd
]---

ROK  :  Unexpected signal 11
received.

msgctl10    1  FAIL  :  in read # = 21245,key =
533a

msgctl10    0  WARN  :  Verify error in child 13, *buf = f1, val = 6d, size
= 3
msgctl10    1  BROK  :  Unexpected signal 11
received.

msgctl10    1  BROK  :  Msgsnd error in child 14, key =   d344 errno  =
43
msgctl10    0  WARN  :  tst_rmdir(): rmobj(/tmp/msgNjyTEb) failed:
lstat(/tmp/msgNjyTEb) failed; errno=2: No such file or directory
msgctl10    0  WARN  :  tst_rmdir(): rmobj(/tmp/msgNjyTEb) failed:
lstat(/tmp/msgNjyTEb) failed; errno=2: No such file or directory
msgctl10    1  FAIL  :  in read # = 54260,key =
d46d

msgctl10    1  B------------[ cut here ]------------

msgctl10    0  TWARN  :  Verify error in child 3, *buf = bb, val = ba, size
= 36
msgctl10    1  TFAIL  :  in read # = 37428,key =
3
msgctl10    1  TBROK  :  Unexpected signal 11
received.
msgctl10    1  TBROK  :  Unexpected signal 11
received.
msgctl10    1  TBROK  :  Unexpected signal 11
received.
msgctl10    1  TBROK  :  Unexpected signal 11
received.
msgctl10    0  TWARN  :  Verify error in child 31, *buf = 43, val = 42, size
= 8
msgctl10    1  TFAIL  :  in read # = 30317,key =
1f
msgctl10    1  TBROK  :  Unexpected signal 11
received.
msgctl10    1  TBROK  :  Unexpected signal 11
received.
msgctl10    1  TBROK  :  Unexpected signal 11
received.
msgctl10    1  TBROK  :  Unexpected signal 11
received.
msgctl10    1  TBROK  :  Unexpected signal 11
received.
msgctl10    1  TBROK  :  Unexpected signal 11
received.
msgctl10    1  TBROK  :  Unexpected signal 11
received.
msgctl10    0  TINFO  :  Removing the message
queue
msgctl10    1  TFAIL  :  Size mismatch in child 91, read # =
15640
msgctl10    0  TINFO  :  Removing the message
queue
msgctl10    1  TBROK  :  Msgsnd error in child 91, key =   3f3d errno  =
43
msgctl10    0  TINFO  :  Removing the message
queue
msgctl10    0  TWARN  :  tst_rmdir(): rmobj(/tmp/msgdsvEQa) failed:
lstat(/tmp/msgdsvEQa) failed; errno=2: No such file or directory

Any clue ?

Thanks in Advance !
-- 
Srikanth Krishnakar
**********************



-- 
"The Good You Do, The Best You GET"

Regards
Srikanth Krishnakar
**********************

--001636e0a826329971046f363cee
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: base64

PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj5UaGUgTFRQIHRlc3QgY2FzZSA8Yj5tc2djdGwx
MC5jPC9iPiBmYWlscyBvbiBsaW51eC0yLjYuMjkuNiBmb3IgUG93ZXJQQyBhcmNoaXRlY3R1cmUg
KHBwYzQ0MCkgQ3Jhc2hlcyB0aGUga2VybmVsIHdpdGggZm9sbG93aW5nIHRyYWNlIDxicj48YnI+
PGJyPm1zZ2N0bDEwoKCgIDGgIEItLS0tLS0tLS0tLS1bIGN1dCBoZXJlIF0tLS0tLS0tLS0tLS2g
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKAgPGJyPgoKa2VybmVsIEJVRyBhdCBhcmNoL3Bvd2VycGMva2Vy
bmVsL3RyYXBzLmM6OTA0IaCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoCA8YnI+T29wczogRXhj
ZXB0aW9uIGluIGtlcm5lbCBtb2RlLCBzaWc6IDUgWyM5XaCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoCA8YnI+CgpQUkVFTVBUIExUVCBORVNUSU5HIExFVkVMIDogMKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIDxicj5WaXJ0ZXg0NDCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgPGJyPgoKTW9kdWxl
cyBsaW5rZWQgaW46oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoCA8YnI+TklQOiBjMDM4MTc4YyBMUjogYzAzODE2NDAgQ1RSOiBjMDI2NTBiY6Cg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoCA8YnI+CgpSRUdTOiBjYWZiYmU3MCBUUkFQ
OiAwNzAwoKAgVGFpbnRlZDogR6CgoKCgIESgoKCgICgyLjYuMjkuNimgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIDxi
cj5NU1I6IDAwMDI5MDAwICZsdDtFRSxNRSxDRSZndDugIENSOiA0ODAwNDIyNKAgWEVSOiAyMDAw
MDAwOKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIDxicj4KClRBU0sgPSBjYWZhMTdmMFs2NDM1XSAmIzM5
O21zZ2N0bDEwJiMzOTsgVEhSRUFEOiBjYWZiYTAwMKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoCA8
YnI+R1BSMDA6IDAwMDAwMDAxIGNhZmJiZjIwIGNhZmExN2YwIGZmZmZmZmRhIDA4MDAwMDAwIDAw
MDAwMDAxIDAwMDAwMDM3IGZmZmZmZmZmoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoCA8YnI+CgpHUFIwODogY2FmYTE3ZjAgYzA0YTAwMDAgMDAwMjEw
MDIgYzAzODE1OTQgMjgwMDQyMjIgMTAwMWY0YmMgYmY5M2Q5NTAgMTAwYjAwMDCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIDxicj5HUFIxNjogMDAw
MDAwMDcgYmY5M2Q5NWMgMTAwMDEyYTAgMTAwMDViODQgMDAwMDAwNjcgMTAwMTc0ZTggMTAwMTc1
MDAgMTAwMTc0ZjigoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgIDxicj4KCkdQUjI0OiAwMDAwMDAwMCAwMDAwMDAwMSAxMDNlYWE1MCAwMDAwMDAwMCAw
MDAwMDAwMCAwMDAwMDAwMCAwODAwMDAwMCBjYWZiYmY1MKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgPGJyPk5JUCBbYzAzODE3OGNdIHByb2dyYW1f
Y2hlY2tfZXhjZXB0aW9uKzB4MWY4LzB4NWY0oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgPGJyPgoK
TFIgW2MwMzgxNjQwXSBwcm9ncmFtX2NoZWNrX2V4Y2VwdGlvbisweGFjLzB4NWY0oKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoCA8YnI+Q2FsbCBUcmFjZTqgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoCA8YnI+CgpbY2FmYmJmMjBdIFtj
MDM4MTY0MF0gcHJvZ3JhbV9jaGVja19leGNlcHRpb24rMHhhYy8weDVmNCAodW5yZWxpYWJsZSmg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgIDxicj5bY2FmYmJmNDBdIFtjMDAwZTc4Y10gcmV0X2Zyb21fZXhjZXB0X2Z1bGwrMHgwLzB4
NGOgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIDxicj4KCkluc3RydWN0aW9uIGR1bXA6oKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgPGJyPjdkODA4
MTIwIDRiYzhhYzIwIDJmODMwMDAxIDQxYmVmZjM4IDJmODNmZmYyIDQxOWUwMDI0IDc3YzAwODA0
IDQxODIwMDRjoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKAgPGJyPgoKM2QyMGMwNGEgODgwOTIwN2MgMmY4MDAwMDAgNDE5ZTAwODAgJmx0
OzBmZTAwMDAwJmd0OyA0ODAwMDAwMCA4MDAxMDAyNCAzY2EwMDAwM6CgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoCA8YnI+LS0tWyBlbmQgdHJh
Y2UgZmQwODkzYzdkOGNlZTFiZCBdLS0toKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoCA8YnI+CgpST0ugIDqgIFVuZXhwZWN0ZWQgc2lnbmFsIDExIHJlY2VpdmVkLqCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIDxicj5tc2djdGwxMKCgoCAxoCBGQUlMoCA6oCBp
biByZWFkICMgPSAyMTI0NSxrZXkgPaAgNTMzYaCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIDxicj4KCm1z
Z2N0bDEwoKCgIDCgIFdBUk6gIDqgIFZlcmlmeSBlcnJvciBpbiBjaGlsZCAxMywgKmJ1ZiA9IGYx
LCB2YWwgPSA2ZCwgc2l6ZSA9IDOgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKAgPGJyPm1zZ2N0bDEwoKCgIDGgIEJST0ugIDqgIFVuZXhwZWN0ZWQgc2ln
bmFsIDExIHJlY2VpdmVkLqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgPGJyPgoKbXNnY3RsMTCgoKAgMaAg
QlJPS6AgOqAgTXNnc25kIGVycm9yIGluIGNoaWxkIDE0LCBrZXkgPaCgIGQzNDQgZXJybm+gID0g
NDOgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oCA8YnI+bXNnY3RsMTCgoKAgMKAgV0FSTqAgOqAgdHN0X3JtZGlyKCk6IHJtb2JqKC90bXAvbXNn
Tmp5VEViKSBmYWlsZWQ6IGxzdGF0KC90bXAvbXNnTmp5VEViKSBmYWlsZWQ7IGVycm5vPTI6IE5v
IHN1Y2ggZmlsZSBvciBkaXJlY3Rvcnk8YnI+Cgptc2djdGwxMKCgoCAwoCBXQVJOoCA6oCB0c3Rf
cm1kaXIoKTogcm1vYmooL3RtcC9tc2dOanlURWIpIGZhaWxlZDogbHN0YXQoL3RtcC9tc2dOanlU
RWIpIGZhaWxlZDsgZXJybm89MjogTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeTxicj5tc2djdGwx
MKCgoCAxoCBGQUlMoCA6oCBpbiByZWFkICMgPSA1NDI2MCxrZXkgPaAgZDQ2ZKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgIDxicj4KCm1zZ2N0bDEwoKCgIDGgIEItLS0tLS0tLS0tLS1bIGN1dCBoZXJlIF0t
LS0tLS0tLS0tLS2gIDxicj48YnI+bXNnY3RsMTCgoKAgMKAgVFdBUk6gIDqgIFZlcmlmeSBlcnJv
ciBpbiBjaGlsZCAzLCAqYnVmID0gYmIsIHZhbCA9IGJhLCBzaXplID0gMzagoKCgoKCgoKCgoKCg
IDxicj5tc2djdGwxMKCgoCAxoCBURkFJTKAgOqAgaW4gcmVhZCAjID0gMzc0Mjgsa2V5ID2gIDOg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgPGJyPgptc2djdGwxMKCg
oCAxoCBUQlJPS6AgOqAgVW5leHBlY3RlZCBzaWduYWwgMTEgcmVjZWl2ZWQuoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgPGJyPm1zZ2N0bDEwoKCgIDGgIFRCUk9LoCA6oCBV
bmV4cGVjdGVkIHNpZ25hbCAxMSByZWNlaXZlZC6goKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoCA8YnI+bXNnY3RsMTCgoKAgMaAgVEJST0ugIDqgIFVuZXhwZWN0ZWQgc2lnbmFs
IDExIHJlY2VpdmVkLqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIDxicj4K
bXNnY3RsMTCgoKAgMaAgVEJST0ugIDqgIFVuZXhwZWN0ZWQgc2lnbmFsIDExIHJlY2VpdmVkLqCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIDxicj5tc2djdGwxMKCgoCAwoCBU
V0FSTqAgOqAgVmVyaWZ5IGVycm9yIGluIGNoaWxkIDMxLCAqYnVmID0gNDMsIHZhbCA9IDQyLCBz
aXplID0gOKCgoKCgoKCgoKCgoKAgPGJyPm1zZ2N0bDEwoKCgIDGgIFRGQUlMoCA6oCBpbiByZWFk
ICMgPSAzMDMxNyxrZXkgPaAgMWagoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoCA8YnI+Cm1zZ2N0bDEwoKCgIDGgIFRCUk9LoCA6oCBVbmV4cGVjdGVkIHNpZ25hbCAxMSBy
ZWNlaXZlZC6goKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoCA8YnI+bXNnY3Rs
MTCgoKAgMaAgVEJST0ugIDqgIFVuZXhwZWN0ZWQgc2lnbmFsIDExIHJlY2VpdmVkLqCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIDxicj5tc2djdGwxMKCgoCAxoCBUQlJPS6Ag
OqAgVW5leHBlY3RlZCBzaWduYWwgMTEgcmVjZWl2ZWQuoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKAgPGJyPgptc2djdGwxMKCgoCAxoCBUQlJPS6AgOqAgVW5leHBlY3RlZCBz
aWduYWwgMTEgcmVjZWl2ZWQuoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAg
PGJyPm1zZ2N0bDEwoKCgIDGgIFRCUk9LoCA6oCBVbmV4cGVjdGVkIHNpZ25hbCAxMSByZWNlaXZl
ZC6goKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoCA8YnI+bXNnY3RsMTCgoKAg
MaAgVEJST0ugIDqgIFVuZXhwZWN0ZWQgc2lnbmFsIDExIHJlY2VpdmVkLqCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIDxicj4KbXNnY3RsMTCgoKAgMaAgVEJST0ugIDqgIFVu
ZXhwZWN0ZWQgc2lnbmFsIDExIHJlY2VpdmVkLqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgIDxicj5tc2djdGwxMKCgoCAwoCBUSU5GT6AgOqAgUmVtb3ZpbmcgdGhlIG1lc3Nh
Z2UgcXVldWWgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgPGJyPm1z
Z2N0bDEwoKCgIDGgIFRGQUlMoCA6oCBTaXplIG1pc21hdGNoIGluIGNoaWxkIDkxLCByZWFkICMg
PSAxNTY0MKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoCA8YnI+Cm1zZ2N0bDEwoKCgIDCgIFRJ
TkZPoCA6oCBSZW1vdmluZyB0aGUgbWVzc2FnZSBxdWV1ZaCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoCA8YnI+bXNnY3RsMTCgoKAgMaAgVEJST0ugIDqgIE1zZ3NuZCBl
cnJvciBpbiBjaGlsZCA5MSwga2V5ID2goCAzZjNkIGVycm5voCA9IDQzoKCgoKCgoKCgoKCgoKCg
oKCgIDxicj5tc2djdGwxMKCgoCAwoCBUSU5GT6AgOqAgUmVtb3ZpbmcgdGhlIG1lc3NhZ2UgcXVl
dWWgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgPGJyPgptc2djdGwx
MKCgoCAwoCBUV0FSTqAgOqAgdHN0X3JtZGlyKCk6IHJtb2JqKC90bXAvbXNnZHN2RVFhKSBmYWls
ZWQ6IGxzdGF0KC90bXAvbXNnZHN2RVFhKSBmYWlsZWQ7IGVycm5vPTI6IE5vIHN1Y2ggZmlsZSBv
ciBkaXJlY3Rvcnk8YnI+PGJyPkFueSBjbHVlID88YnIgY2xlYXI9ImFsbCI+PGJyPlRoYW5rcyBp
biBBZHZhbmNlICE8YnI+PGZvbnQgY29sb3I9IiM4ODg4ODgiPi0tIDxicj4KU3Jpa2FudGggS3Jp
c2huYWthcjxicj4qKioqKioqKioqKioqKioqKioqKioqPGJyPgo8L2ZvbnQ+PC9kaXY+PGJyPjxi
ciBjbGVhcj0iYWxsIj48YnI+LS0gPGJyPiZxdW90O1RoZSBHb29kIFlvdSBEbywgVGhlIEJlc3Qg
WW91IEdFVCZxdW90Ozxicj48YnI+UmVnYXJkczxicj5TcmlrYW50aCBLcmlzaG5ha2FyPGJyPioq
KioqKioqKioqKioqKioqKioqKio8YnI+Cg==
--001636e0a826329971046f363cee--


--===============3133113188918386670==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============3133113188918386670==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3133113188918386670==--

