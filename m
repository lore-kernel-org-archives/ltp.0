From: Steve Muckle <smuckle@google.com>
Date: Wed, 24 Jul 2019 16:52:03 -0700
Subject: [LTP] [PATCH v3] syscalls/sendmmsg: add new test
In-Reply-To: <20190724134155.GC19478@rei.lan>
References: <20190723203133.202257-1-smuckle@google.com>
 <20190724134155.GC19478@rei.lan>
Message-ID: <2d8ac294-d537-43d2-eb41-f2fcfed82a2c@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril, thanks for your feedback.

On 7/24/19 6:42 AM, Cyril Hrubis wrote:
>> diff --git a/configure.ac b/configure.ac
>> index 3dcf282e8..5e4e7f1f9 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -82,9 +82,11 @@ AC_CHECK_FUNCS([ \
>>       pwritev \
>>       pwritev2 \
>>       readlinkat \
>> +    recvmmsg \
>>       renameat \
>>       renameat2 \
>>       sched_getcpu \
>> +    sendmmsg \
>>       sigpending \
>>       splice \
>>       stime \
>> @@ -253,6 +255,7 @@ LTP_CHECK_TIME
>>   LTP_CHECK_TIMERFD
>>   test "x$with_tirpc" = xyes && LTP_CHECK_TIRPC
>>   LTP_CHECK_TPACKET_V3
>> +LTP_CHECK_MMSGHDR
> 
> This seems to be already there under the # custom functions comment.

Ah yes looks like this got added while I was sitting on the patch, and I 
failed to notice it when I rebased. Removed.

>> +	addr.sin_family = AF_INET;
>> +	addr.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
>> +	addr.sin_port = htons(port);
> 
> The port returned by TST_GET_UNUSED_PORT() is already in network byte
> order, we found a bug recently where test was failing randomly since if
> we attempt to convert the value we may end up with priviledged port
> number if we are unlucky.

Fixed.

> 
>> +	SAFE_CONNECT(send_sockfd, (struct sockaddr *) &addr, sizeof(addr));
>> +
>> +	memset(msg1, 0, sizeof(msg1));
>> +	msg1[0].iov_base = "one";
>> +	msg1[0].iov_len = 3;
>> +	msg1[1].iov_base = "two";
>> +	msg1[1].iov_len = 3;
>> +
>> +	memset(&msg2, 0, sizeof(msg2));
>> +	msg2.iov_base = "three";
>> +	msg2.iov_len = 5;
>> +
>> +	memset(msg, 0, sizeof(msg));
>> +	msg[0].msg_hdr.msg_iov = msg1;
>> +	msg[0].msg_hdr.msg_iovlen = 2;
>> +
>> +	msg[1].msg_hdr.msg_iov = &msg2;
>> +	msg[1].msg_hdr.msg_iovlen = 1;
>> +
>> +	sem_wait(&send_sem);
>> +
>> +	while (msgs) {
>> +		retval = do_sendmmsg(send_sockfd, msg, msgs, 0);
>> +		if (retval < 0) {
>> +			/*
>> +			 * tst_brk is used here so reader is not left waiting
>> +			 * for data - note timeout for recvmmsg does not work
>> +			 * as one would expect (see man page)
>> +			 */
>> +			tst_brk(TBROK|TTERRNO, "sendmmsg failed");
>> +			goto out;
>> +		}
>> +		msgs -= retval;
> 
> Wouldn't this resend the start of the message again if we got
> interrupted in the middle?

The failure modes aren't clear to me. Based on the man page for sendmmsg 
it sounded like it returns the number of messages successfully sent, and 
I assumed that unsuccessfully sent messages were not partially sent? The 
sendmsg page says that it only sends messages that can fit atomically in 
the underlying protocol.

> I guess that the correct retry would loop over the messages and
> decrement the iov_len and shift the buffers based on the msg_len.
> Something as:
> 
> retry:
> 	retval = do_sendmmsg(send_sockfd, msg, msgs, 0);
> 
> 	for (i = 0; i < retval; i++) {
> 		int transmitted = msg[i].msg_len;
> 		msg[i].msg_len = 0;
> 		for (j = 0; j < msg[i].msg_iovlen; j++) {
> 			int len = msg[i].msg_iov[j].msg_iovlen;
> 
> 			/* whole buffer send */
> 			if (transmitted >= len) {
> 				transmitted -= len;
> 				msg[i].msg_iov[j].msg_iovlen = 0;
> 				continue;
> 			}
> 
> 			msg[i].msg_iov[j].msg_iovlen -= transmitted;
> 			msg[i].msg_iov[j].msg_iov += transmitted;
> 
> 			goto retry;
> 		}
> 	}
> 
> Also I'm pretty sure that we will actually happen to write the whole
> buffer unless we fill up the kernel buffers, which we hardly will with
> a few bytes. So maybe we should just send the message here and check
> that the msg_len are filled correctly in this case.

That works for me, after all if we get unlucky and cannot send the first 
message in the vector, sendmmsg() returns an error and the test will 
fail. So retrying on the second message is a bit inconsistent.

>> +	addr.sin_port = htons(port);
> 
> Here as well, the htons() should be dropped.

Fixed.

thanks,
steve
