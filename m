Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MOZgz-0007Ty-8K
	for ltp-list@lists.sourceforge.net; Wed, 08 Jul 2009 16:08:21 +0000
Received: from an-out-0708.google.com ([209.85.132.240])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MOZgs-0004ec-KT
	for ltp-list@lists.sourceforge.net; Wed, 08 Jul 2009 16:08:21 +0000
Received: by an-out-0708.google.com with SMTP id c38so2342333ana.37
	for <ltp-list@lists.sourceforge.net>;
	Wed, 08 Jul 2009 09:08:13 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 8 Jul 2009 09:08:13 -0700
Message-ID: <364299f40907080908y531e3fa8m2c783f9328278ddd@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Content-Type: multipart/mixed; boundary=001485f8724840baa2046e33f233
Subject: [LTP] [PATCH] Fix IDcheck.sh - awk problem
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

--001485f8724840baa2046e33f233
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On Wed, Jul 8, 2009 at 7:36 AM, Michal Simek<michal.simek@petalogix.com> wrote:
> Garrett Cooper wrote:
>> On Tue, Jul 7, 2009 at 11:04 PM, Michal Simek<michal.simek@petalogix.com> wrote:
>>
>>> Hi All,
>>>
>>> There will be good to prevent missing /etc/passwd for installing to
>>> different folder.
>>>
>>> export DESTDIR=`pwd`/nfs
>>> mkdir -p nfs
>>> make install
>>
>> That's part of the reason why I wanted it to be reviewed before it was
>> committed, and I halfway expected Mike to provide that assistance but
>> he didn't... *sigh*.
>>
>> Does the /etc/passwd // /etc/group file exist?
>>
> Of course not because I cross compile ltp for Microblaze - correct
> /etc/passwd - group is on
> target system. Maybe worth to remove calling IDcheck.sh from make
> install and call it only before
> running the test.

Well, it's up to you folks how you want to do it, because it should
not be called by default, but it still is because I haven't added my
changes into the top-level Makefile yet, because that's under review.

=================
PATCH FOLLOWS
=================

This fixes the bad DESTDIR logic that was recently checked in, as
validated with the output shown below (see the attached file --
test_IDcheck_sh_regression_set.py -- for more details):

Nose output:

gcooper@orangebox /scratch/ltp-vanilla/ltp $ nosetests
test_IDcheck_sh_regression_set.py
Checking for required user/group ids

'nobody' user id and group found.
'bin' user id and group found.
'daemon' user id and group found.
Users group found.
Sys group found.
Required users/groups exist.
.Checking for required user/group ids


*****************************************
* Required users/groups do NOT exist!!! *
*                                       *
* Some kernel/syscall tests will FAIL!  *
*****************************************
.Checking for required user/group ids


*****************************************
* Required users/groups do NOT exist!!! *
*                                       *
* Some kernel/syscall tests will FAIL!  *
*****************************************
.Checking for required user/group ids


*****************************************
* Required users/groups do NOT exist!!! *
*                                       *
* Some kernel/syscall tests will FAIL!  *
*****************************************
.Checking for required user/group ids

Failed to touch //etc/group or //etc/passwd
.Checking for required user/group ids

Creating entries for nobody
Creating entries for bin
Creating entries for daemon
Required users/groups exist.
.Checking for required user/group ids

Failed to touch /tmp/tmpvQw2kZ/etc/group or /tmp/tmpvQw2kZ/etc/passwd
.Checking for required user/group ids

Failed to touch /some/path/that/does/not/exist/etc/group or
/some/path/that/does/not/exist/etc/passwd
.
----------------------------------------------------------------------
Ran 8 tests in 0.090s

OK

Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

Index: IDcheck.sh
===================================================================
RCS file: /cvsroot/ltp/ltp/IDcheck.sh,v
retrieving revision 1.19
diff -u -r1.19 IDcheck.sh
--- IDcheck.sh  7 Jul 2009 14:30:27 -0000       1.19
+++ IDcheck.sh  8 Jul 2009 16:06:42 -0000
@@ -22,7 +22,6 @@
 #

 # Prompt user if ids/groups should be created
-clear
 echo "Checking for required user/group ids"
 echo ""

@@ -41,12 +40,11 @@

 # find entry.
 fe() {
-       ID=$1; shift
-       FILE=$1; shift
-       awk "/^$ID:/ { FOUND=1 } END { if (\$FOUND == 1) { exit 0; }
exit 1; }" \
-       "$FILE"
-       ec=$?
-       echo "$ID => $ec"
+    ID=$1; shift
+    FILE=$1; shift
+    [ -e "$FILE" ] || return $?
+    awk "/^$ID:/ { FOUND=1 } END { if (\$FOUND == 1) { exit 1; } exit 0; }" \
+    "$FILE"
 }

 prompt_for_create() {
@@ -70,13 +68,12 @@
        EUID=$(id -u)
 fi

-if [ -e "$passwd" -a ! -r "$passwd" ] ; then
-       echo "/etc/passwd not readable by uid $EUID"
+for i in "$passwd" "$group"; do
+    if [ -e "$i" -a ! -r "$i" ] ; then
+       echo "$i not readable by uid $EUID"
        exit 1
-elif [ -e "$group" -a ! -r "$group" ] ; then
-       echo "$group not readable by uid $EUID"
-       exit 1
-fi
+    fi
+done

 fe bin "$passwd"; NO_BIN_ID=$?
 fe daemon "$passwd"; NO_DAEMON_ID=$?
@@ -110,10 +107,10 @@
 #debug_vals

 if [ $CREATE_ENTRIES -ne 0 ] ; then
-       if ! touch "$group" ; then
-               echo "Couldn't touch $group"
-               exit 1
-       fi
+    if ! touch "$group" "$passwd" 2>/dev/null; then
+        echo "Failed to touch $group or $passwd"
+        exit 1
+    fi
 fi

 make_user_group() {

--001485f8724840baa2046e33f233
Content-Type: application/octet-stream; 
	name="test_IDcheck_sh_regression_set.py"
Content-Disposition: attachment; filename="test_IDcheck_sh_regression_set.py"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fww8t3l10

IiIiCgogICAgSURjaGVjay5zaCByZWdyZXNzaW9uIHRlc3Qgc3VpdGUuCgogICAgQ29weXJpZ2h0
IChDKSAyMDA5LCBDaXNjbyBTeXN0ZW1zIEluYy4KCiAgICBUaGlzIHByb2dyYW0gaXMgZnJlZSBz
b2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1vZGlmeQogICAgaXQgdW5k
ZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhcyBwdWJsaXNo
ZWQgYnkKICAgIHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb247IGVpdGhlciB2ZXJzaW9uIDIg
b2YgdGhlIExpY2Vuc2UsIG9yCiAgICAoYXQgeW91ciBvcHRpb24pIGFueSBsYXRlciB2ZXJzaW9u
LgoKICAgIFRoaXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0IGl0IHdp
bGwgYmUgdXNlZnVsLAogICAgYnV0IFdJVEhPVVQgQU5ZIFdBUlJBTlRZOyB3aXRob3V0IGV2ZW4g
dGhlIGltcGxpZWQgd2FycmFudHkgb2YKICAgIE1FUkNIQU5UQUJJTElUWSBvciBGSVRORVNTIEZP
UiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4gIFNlZSB0aGUKICAgIEdOVSBHZW5lcmFsIFB1YmxpYyBM
aWNlbnNlIGZvciBtb3JlIGRldGFpbHMuCgogICAgWW91IHNob3VsZCBoYXZlIHJlY2VpdmVkIGEg
Y29weSBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgYWxvbmcKICAgIHdpdGggdGhp
cyBwcm9ncmFtOyBpZiBub3QsIHdyaXRlIHRvIHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb24s
IEluYy4sCiAgICA1MSBGcmFua2xpbiBTdHJlZXQsIEZpZnRoIEZsb29yLCBCb3N0b24sIE1BIDAy
MTEwLTEzMDEgVVNBLgoKR2FycmV0dCBDb29wZXIsIEp1bHkgMjAwOQoKQ29weXJpZ2h0IChjKSAy
MDA5IGJ5IENpc2NvIFN5c3RlbXMsIEluYy4KQWxsIHJpZ2h0cyByZXNlcnZlZAoKUmVxdWlyZXMg
bm9zZSAwLjEwKy4KCiIiIgoKZnJvbSBjb3B5IGltcG9ydCBkZWVwY29weQppbXBvcnQgb3MKdHJ5
OgogICAgIyBjaGVja19jYWxsIG9ubHkgZXhpc3RzIGluIDIuNSssIGFzIHdlbGwgYXMgdGhlIGBm
aW5hbGx5JyBjYWxsIHVzZWQgbGF0ZXIKICAgICMgb24gaW4gdGhlIGZpbGUuCiAgICBmcm9tIHN1
YnByb2Nlc3MgaW1wb3J0IENhbGxlZFByb2Nlc3NFcnJvciwgY2hlY2tfY2FsbApleGNlcHQgSW1w
b3J0RXJyb3I6CiAgICByYWlzZSBJbXBvcnRFcnJvcigiWW91J3JlIHJ1bm5pbmcgUHl0aG9uIDw9
IHYyLjQuIFBsZWFzZSB1cGdyYWRlIGFuZCB0cnkiCiAgICAgICAgICAgICAgICAgICAgICAiYWdh
aW4uLi4iKQppbXBvcnQgc3lzCmZyb20gdGVtcGZpbGUgaW1wb3J0IG1rZHRlbXAKCmRlZiBydW5f
SURjaGVja19zaChlbnYsIHBvc2l0aXZlX3RjLCBjbWQ9Jy4vSURjaGVjay5zaCcpOgogICAgIiIi
IFJ1biB0aGUgY29tbWFuZCwgZXhwZWN0IGEgcmVzdWx0IChwb3NpdGl2ZSBvciBuZWdhdGl2ZSku
ICIiIgogICAgdHJ5OgogICAgICAgIHN5cy5zdGRvdXQud3JpdGUoJyAnLmpvaW4oW3N0cihpKSBm
b3IgaSBpbiBbY21kLCBlbnYsIHBvc2l0aXZlX3RjXV0pICsKICAgICAgICAgICAgICAgICAgICAg
ICAgICdcbicpCiAgICAgICAgY2hlY2tfY2FsbChbICcnIF0sIGV4ZWN1dGFibGU9Y21kLCBlbnY9
ZW52LCBzaGVsbD1UcnVlKQogICAgZXhjZXB0IENhbGxlZFByb2Nlc3NFcnJvcjoKICAgICAgICBp
ZiBwb3NpdGl2ZV90YzoKICAgICAgICAgICAgcmFpc2UKICAgIGVsc2U6CiAgICAgICAgaWYgbm90
IHBvc2l0aXZlX3RjOgogICAgICAgICAgICByYWlzZSBFeGNlcHRpb24oJyVzIGZhaWxlZCBzaWxl
bnRseScgJSBjbWQpCgpFTlYgPSB7fQoKIwojIFdoYXQgcGFzc3dvcmQgZW50cmllcyBkbyB3ZSBl
eHBlY3QgdG8gYmUgd2l0aGluIGVhY2ggZmlsZSBpbiBvcmRlciB0byBwYXNzCiMgd2hlbiBDUkVB
VEVfRU5UUklFUz0wID8KIwpFWFBFQ1RFRF9FTEVNRU5UUyA9IHt9CkVYUEVDVEVEX0VMRU1FTlRT
Wydncm91cCddID0gWyAnYmluJywgJ2RhZW1vbicsICdub2JvZHknIF0KRVhQRUNURURfRUxFTUVO
VFNbJ3Bhc3N3ZCddID0gWyAnYmluJywgJ2RhZW1vbicsICdub2JvZHknLCAnc3lzJywgJ3VzZXJz
JyBdCgpORUdfREVTVERJUiwgUE9TX0RFU1RESVIgPSBOb25lLCBOb25lCgpkZWYgc2V0dXBfbW9k
dWxlKCk6CiAgICAiIiIgR2VuZXJhdGUgdGhlIHBvc2l0aXZlIGFuZCBuZWdhdGl2ZSBERVNURElS
J3MuICIiIgogICAgZ2xvYmFsIEVOViwgTkVHX0RFU1RESVIsIFBPU19ERVNURElSCgogICAgIyBX
ZSBuZWVkIHRvIGVzdGFibGlzaCBhIG1pbmltdW0gZW52aXJvbm1lbnQgZm9yIHRoZSBzY3JpcHQs
IG9yIElEY2hlY2suc2gKICAgICMgd2lsbCBwcmludCBvdXQgbW9yZSBzcHVyaW91cyBtZXNzYWdl
cyB0aGFuIG5lY2Vzc2FyeSB3aGVuIHVzZWQgd2l0aAogICAgIyBzdWJwcm9jZXNzLCBldmVuIHRo
b3VnaCBzaGVsbD1UcnVlLgogICAgZm9yIGV2IGluIFsgJ1BBVEgnLCAnVEVSTScgXToKICAgICAg
ICBFTlZbZXZdID0gb3MuZ2V0ZW52KGV2LCAnJykKCiAgICBQT1NfREVTVERJUiA9IG1rZHRlbXAo
KQogICAgTkVHX0RFU1RESVIgPSBta2R0ZW1wKCkKCiAgICBvcy5tYWtlZGlycyhvcy5wYXRoLmpv
aW4oUE9TX0RFU1RESVIsICdldGMnKSkKCmRlZiB0ZWFyZG93bl9tb2R1bGUoKToKICAgICIiIiBH
ZXQgcmlkIG9mIHRoZSBwb3NpdGl2ZSBERVNURElSLiBvcy5yZW1vdmVkaXJzKCkgYWx3YXlzIGZh
aWxzLCBzbyBsZXQncwogICAgdXNlIG9zLndhbGsgKyBvcy5yZW1vdmUgaW5zdGVhZC4gIiIiCgog
ICAgaWYgb3MucGF0aC5pc2RpcihQT1NfREVTVERJUik6CgogICAgICAgIGZvciByb290LCBkaXJz
LCBmaWxlcyBpbiBvcy53YWxrKFBPU19ERVNURElSLCB0b3Bkb3duPUZhbHNlKToKICAgICAgICAg
ICAgZm9yIF9maWxlIGluIGZpbGVzOgogICAgICAgICAgICAgICAgb3MucmVtb3ZlKG9zLnBhdGgu
am9pbihyb290LCBfZmlsZSkpCiAgICAgICAgICAgIGZvciBfZGlyIGluIGRpcnM6CiAgICAgICAg
ICAgICAgICBvcy5yZW1vdmVkaXJzKG9zLnBhdGguam9pbihyb290LCBfZGlyKSkKCmRlZiB0ZXN0
X0lEY2hlY2tfc2goKToKICAgICIiIiBEb2VzIERFU1RESVIgZnVuY3Rpb25hbGl0eSByZWFsbHkg
d29yaz8KCiAgICBUcnkgNCBkaWZmZXJlbnQgcGVybXV0YXRpb25zIG9mIERFU1RESVI6CgogICAg
MS4gQ3VycmVudCByb290ZnMuIFdpbGwgZmFpbCBpZiBJIGRvbid0IGhhdmUgd3JpdGUgYWNjZXNz
IHRvIAoKICAgIFNlYW4gQ29ubmVyeTogSSd2ZSBiZWVuIHRyeWluZyB0byBnZXQgYSBERVNURElS
IHRvIHdvcmsgZm9yIGFnZXMhCiAgICAoU05MIC8gQW5hbGJ1bWNvdmVyIHJlZmVyZW5jZSA6KS4u
LikuICIiIgoKICAgIGVudiA9IEVOVgoKICAgIGZvciBDUkVBVEVfRU5UUklFUyBpbiBbICcwJywg
JzEnIF06CgogICAgICAgIGZvciBERVNURElSIGluIFsgJy8nLCBQT1NfREVTVERJUiwgTkVHX0RF
U1RESVIsICcvc29tZS9wYXRoL3RoYXQvZG9lcy9ub3QvZXhpc3QnIF06CgogICAgICAgICAgICBl
dGNkaXIgPSBvcy5wYXRoLmpvaW4oREVTVERJUiwgJ2V0YycpCgogICAgICAgICAgICBleHBlY3Rf
cG9zID0gRmFsc2UKCiAgICAgICAgICAgIGlmIGJvb2woaW50KENSRUFURV9FTlRSSUVTKSk6Cgog
ICAgICAgICAgICAgICAgIyBXZSBleHBlY3QgdGhlIHJlc3VsdHMgdG8gYmUgcG9zaXRpdmUgaWYg
Q1JFQVRFX0VOVFJJRVM9MSBhbmQKICAgICAgICAgICAgICAgICMgdGhlIHBhdGggaXMgd3JpdGFi
bGUsIGJlY2F1c2UgSURjaGVjay5zaCB3aWxsIHByb3Blcmx5IGZpbGwKICAgICAgICAgICAgICAg
ICMgaW4gdGhlIGJsYW5rcy4KCiAgICAgICAgICAgICAgICBleHBlY3RfcG9zID0gb3MuYWNjZXNz
KG9zLnBhdGguam9pbihldGNkaXIpLCBvcy5XX09LKQoKICAgICAgICAgICAgZWxzZToKCiAgICAg
ICAgICAgICAgICAjIE90aGVyd2lzZSwgaWYgYWxsIG9mIHRoZSBlbnRyaWVzIGV4aXN0IGFuZCBD
UkVBVEVfRU5UUklFUz0wLAogICAgICAgICAgICAgICAgIyB3ZSBoYXZlIGEgd2lubmVyIQoKICAg
ICAgICAgICAgICAgIGZvciBpIGluIEVYUEVDVEVEX0VMRU1FTlRTLmtleXMoKToKCiAgICAgICAg
ICAgICAgICAgICAgX2ZpbGUgPSBvcy5wYXRoLmpvaW4oZXRjZGlyLCBpKQoKICAgICAgICAgICAg
ICAgICAgICBzeXMuc3Rkb3V0LndyaXRlKCdXaWxsIG9wZW46ICVzXG4nICUgX2ZpbGUpCgogICAg
ICAgICAgICAgICAgICAgIGlmIG5vdCBvcy5hY2Nlc3MoX2ZpbGUsIG9zLlJfT0spOgogICAgICAg
ICAgICAgICAgICAgICAgICAjIEV4cGVjdCBuZWdhdGl2ZSByZXN1bHRzLgogICAgICAgICAgICAg
ICAgICAgICAgICBicmVhawoKICAgICAgICAgICAgICAgICAgICBmZCA9IG9wZW4oX2ZpbGUpCgog
ICAgICAgICAgICAgICAgICAgIHRyeToKICAgICAgICAgICAgICAgICAgICAgICAgbGluZXMgPSBm
ZC5yZWFkbGluZXMoKQogICAgICAgICAgICAgICAgICAgIGZpbmFsbHk6CiAgICAgICAgICAgICAg
ICAgICAgICAgIGZkLmNsb3NlKCkKCiAgICAgICAgICAgICAgICAgICAgZm9yIGV4cGVjdGVkX2Vs
ZW1lbnQgaW4gRVhQRUNURURfRUxFTUVOVFNbaV06CgogICAgICAgICAgICAgICAgICAgICAgICBz
eXMuc3Rkb3V0LndyaXRlKCclcyAtICVzJyAlIChfZmlsZSwgZXhwZWN0ZWRfZWxlbWVudCkpCgog
ICAgICAgICAgICAgICAgICAgICAgICBmb3IgbGluZSBpbiBsaW5lczoKCiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBpZiBsaW5lLnN0YXJ0c3dpdGgoZXhwZWN0ZWRfZWxlbWVudCArICI6Iik6
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZXhwZWN0X3BvcyA9IFRydWUKICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBzeXMuc3Rkb3V0LndyaXRlKCcgLSBmb3VuZFxuJykK
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBicmVhawoKICAgICAgICAgICAgICAgICAg
ICAgICAgZWxzZToKICAgICAgICAgICAgICAgICAgICAgICAgICAgICMgSWYgd2UgaXRlcmF0ZWQg
dGhyb3VnaCBhbGwgdGhlIGxpbmVzIGFuZCBkaWRuJ3QKICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICMgYnJlYWsgKGFuZCBoZW5jZSBkaWRuJ3QgZW5kIHVwIGluIHRoaXMgZWxzZQogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIyBzdGF0ZW1lbnQpLCB3ZSBkaWRuJ3QgZmluZCBvdXIgZW50
cnkgb2YgaW50ZXJlc3QuCiAgICAgICAgICAgICAgICAgICAgICAgICAgICBzeXMuc3Rkb3V0Lndy
aXRlKCctIG5vdCBmb3VuZFxuJykKICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrCgog
ICAgICAgICAgICAgICAgICAgIGlmIG5vdCBleHBlY3RfcG9zOgogICAgICAgICAgICAgICAgICAg
ICAgICBicmVhawoKICAgICAgICAgICAgZW52WyJDUkVBVEVfRU5UUklFUyJdID0gQ1JFQVRFX0VO
VFJJRVMKICAgICAgICAgICAgZW52WyJERVNURElSIl0gPSBERVNURElSCgogICAgICAgICAgICB5
aWVsZCBydW5fSURjaGVja19zaCwgZW52LCBleHBlY3RfcG9zCg==
--001485f8724840baa2046e33f233
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
--001485f8724840baa2046e33f233
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--001485f8724840baa2046e33f233--

