From: Tidjani Ali Hissein ACHE <tidjanialihissein.ache@st.com>
Date: Fri, 27 Nov 2015 13:08:12 +0100
Subject: [LTP] How to identify all LTP tests needing block device and how to
 skip them?
Message-ID: <565847AC.9040807@st.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

I contact you because i am running LTP tests on a board and at the end i
always get this error message :
"
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: 20140422

###############################################################

              Done executing testcases.
              LTP Version:  20140422
###############################################################
losetup: /dev/loop0: failed to use device: No such file or directory
"

I think that occurs because some tests actually need block device which
i don't have. Although all tests are executed regardless of this error,
the blocking point is that i run LTP tests from custom script and this
error provokes an exit from custom script (of course after LTP tests
execution is done).
My question is how can i identify all these tests which can potentially
create this error and skip them?

Thank you for your reply.

Regards,
Tidjani ACHE
