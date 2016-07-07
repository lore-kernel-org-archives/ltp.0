From: fixed-term.Oleksij.Rempel <fixed-term.Oleksij.Rempel@de.bosch.com>
Date: Thu, 7 Jul 2016 15:04:31 +0200
Subject: [LTP] updating message_queue_test_02_*
In-Reply-To: <577E4340.4060208@de.bosch.com>
References: <577E4340.4060208@de.bosch.com>
Message-ID: <577E535F.2040606@de.bosch.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 07.07.2016 13:55, fixed-term.Oleksij.Rempel wrote:
> Hallo all,
> 
> it is kind of a duplication of this case:
> https://github.com/linux-test-project/ltp/issues/75
> 
> some of message_queue_test_02_* are fail on our configuration, it looks
> like the reason is hardcoded tmp path, which is different in our test setup.
> 
> Looks like this tests should be updated to use current ltp bindings..
> which should also fix this issue.  Do any one already working on it? If
> not, me or some of us will try to do it.
> 

hm...
to execute *message_queue_test_02_rcv* properly, first should be
*message_queue_test_02_snd* executed. And most important, target should
not be reseted after message_queue_test_02_snd. If this happens,
message_queue_test_02_rcv will hang forever.
It is not looks like proper behaviour (it is not theoretical assumption.).

May be message_queue_test_02_rcv should be wrapped by a script which
will start rcv in background and then send after short sleep?
And some how make sure that message_queue_test_02_rcv wont wait forever?

Any comments?
