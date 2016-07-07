From: fixed-term.Oleksij.Rempel <fixed-term.Oleksij.Rempel@de.bosch.com>
Date: Thu, 7 Jul 2016 13:55:44 +0200
Subject: [LTP] updating message_queue_test_02_*
Message-ID: <577E4340.4060208@de.bosch.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hallo all,

it is kind of a duplication of this case:
https://github.com/linux-test-project/ltp/issues/75

some of message_queue_test_02_* are fail on our configuration, it looks
like the reason is hardcoded tmp path, which is different in our test setup.

Looks like this tests should be updated to use current ltp bindings..
which should also fix this issue.  Do any one already working on it? If
not, me or some of us will try to do it.

-- 
Best regards,
Oleksij Rempel
CM-AI/ECO3
Tel.: +49(5121)49-2962
