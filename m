From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Mon, 19 Oct 2020 16:10:04 +0800
Subject: [LTP] [PATCH] syscalls/send02: Improve message
In-Reply-To: <71c2d6b7-5c49-96c6-f1ba-1370fd7a5dd6@oracle.com>
References: <1602834345-24019-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <71c2d6b7-5c49-96c6-f1ba-1370fd7a5dd6@oracle.com>
Message-ID: <5F8D49DC.4060606@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey
> On 16.10.2020 10:45, Yang Xu wrote:
>> This case sometimes fails, output as below:
>>
>> tst_test.c:1250: TINFO: Timeout per run is 0h 05m 00s
>> send02.c:86: TFAIL: recv() error: EAGAIN/EWOULDBLOCK (11)
>> send02.c:86: TFAIL: recv() error: EAGAIN/EWOULDBLOCK (11)
>> send02.c:86: TFAIL: recv() error: EAGAIN/EWOULDBLOCK (11)
>> send02.c:86: TFAIL: recv() error: EAGAIN/EWOULDBLOCK (11)
>>
>>  From this output, we don't know which subcase fails(tcp,udp,send,sendto).
>> So add some message and make this clear.
>>
>> Now this case fails as below:
>> tst_test.c:1250: TINFO: Timeout per run is 0h 05m 00s
>> send02.c:124: TINFO: Testing TCP send
>> send02.c:87: TFAIL: recv() error at the 776 times(expsize 17): EAGAIN/EWOULDBLOCK (11)
>
> recv(..., MSG_DONTWAIT) can fail with EAGAIN/EWOULDBLOCK at any time,
> so it should be a valid error... why it is a failure in the test?
I guess  it only sends a small data and works well on most machines, so 
we think it is a failure.
>
> If we expect some message to receive, we should call recv() again
> for EAGAIN/EWOULDBLOCK errors. And with MSG_MORE case, just return
> immediately, i.e. something like this:
>
>         while (1) {
>                  TEST(recv(sock, recvbuf, RECVSIZE, MSG_DONTWAIT));
>
>                  if (TST_RET == -1) {
>                          if (TST_ERR == EAGAIN || TST_ERR == EWOULDBLOCK) {
>                                  if (expsize)
>                                          continue;
>                                  else
>                                          break;
>                          }
>
>                          /* unexpected error */
>                          tst_res(TFAIL | TTERRNO, "recv() error, expsize %ld, it %d", expsize, i);
>                          return 0;
>                  }
>
> 		if (TST_RET<  0) {
>                          tst_res(TFAIL | TTERRNO, "Invalid recv() return value %ld",
>                                  TST_RET);
>                          return 0;
>                  }
>
>                  if (!expsize || TST_RET != expsize) {
>                          tst_res(TFAIL, "recv() read %ld bytes, expected %ld", TST_RET,
>                                  expsize);
>                          return 0;
>                  }
>
> 		break;
> 	}

It looks ok. This test only checks MSG_MORE whether can get 
EAGAIN/EWOULDBLOCK erro immediately, so for other situations, we just
ensure it can receive message sucessfully.

>
>
>> send02.c:124: TINFO: Testing UDP send
>> send02.c:87: TFAIL: recv() error at the 1 times(expsize 16): EAGAIN/EWOULDBLOCK (11)
>> send02.c:124: TINFO: Testing UDP sendto
>> send02.c:87: TFAIL: recv() error at the 1 times(expsize 16): EAGAIN/EWOULDBLOCK (11)
>> send02.c:124: TINFO: Testing UDP sendmsg
>> send02.c:87: TFAIL: recv() error at the 1 times(expsize 16): EAGAIN/EWOULDBLOCK (11)
>>
>> Signed-off-by: Yang Xu<xuyang2018.jy@cn.fujitsu.com>
>> ---
>>   testcases/kernel/syscalls/send/send02.c | 20 +++++++++++---------
>>   1 file changed, 11 insertions(+), 9 deletions(-)
>>
>> diff --git a/testcases/kernel/syscalls/send/send02.c b/testcases/kernel/syscalls/send/send02.c
>> index 5630230fa..719e86a90 100644
>> --- a/testcases/kernel/syscalls/send/send02.c
>> +++ b/testcases/kernel/syscalls/send/send02.c
>> @@ -71,7 +71,7 @@ static void setup(void)
>>   	memset(sendbuf, 0x42, SENDSIZE);
>>   }
>>
>> -static int check_recv(int sock, long expsize)
>> +static int check_recv(int sock, long expsize, int loop)
>>   {
>>   	char recvbuf[RECVSIZE] = {0};
>>
>> @@ -83,19 +83,20 @@ static int check_recv(int sock, long expsize)
>>   			return 1;
>>
>>   		/* unexpected error */
>> -		tst_res(TFAIL | TTERRNO, "recv() error");
>> +		tst_res(TFAIL | TTERRNO, "recv() error at the %d times(expsize"
>> +			" %ld)", loop, expsize);
>
> It's better to have a single line message, and arguments on another one:
> tst_res(TFAIL | TTERRNO, "recv() error at step %d, expsize %ld",
>          ...);
OK. Will do it in v2 patch

Best Regards
Yang Xu
>
>>   		return 0;
>>   	}
>>
>>   	if (TST_RET<  0) {
>> -		tst_res(TFAIL | TTERRNO, "Invalid recv() return value %ld",
>> -			TST_RET);
>> +		tst_res(TFAIL | TTERRNO, "Invalid recv() return value %ld at"
>> +			" the %d times(expsize %ld)", TST_RET, loop, expsize);
>>   		return 0;
>>   	}
>>
>>   	if (TST_RET != expsize) {
>> -		tst_res(TFAIL, "recv() read %ld bytes, expected %ld", TST_RET,
>> -			expsize);
>> +		tst_res(TFAIL, "recv() read %ld bytes, expected %ld at the"
>> +			" %d times", TST_RET, expsize, loop);
>>   		return 0;
>>   	}
>>
>> @@ -120,6 +121,7 @@ static void run(unsigned int n)
>>   	struct test_case *tc = testcase_list + n;
>>   	socklen_t len = sizeof(addr);
>>
>> +	tst_res(TINFO, "Testing %s", tc->name);
>>   	tst_init_sockaddr_inet_bin(&addr, INADDR_LOOPBACK, 0);
>>   	listen_sock = SAFE_SOCKET(tc->domain, tc->type, tc->protocol);
>>   	dst_sock = listen_sock;
>> @@ -139,19 +141,19 @@ static void run(unsigned int n)
>>   			dst_sock = SAFE_ACCEPT(listen_sock, NULL, NULL);
>>
>>   		tc->send(sock, sendbuf, SENDSIZE, 0);
>> -		ret = check_recv(dst_sock, SENDSIZE);
>> +		ret = check_recv(dst_sock, SENDSIZE, i + 1);
>>
>>   		if (!ret)
>>   			break;
>>
>>   		tc->send(sock, sendbuf, SENDSIZE, MSG_MORE);
>> -		ret = check_recv(dst_sock, 0);
>> +		ret = check_recv(dst_sock, 0, i + 1);
>>
>>   		if (!ret)
>>   			break;
>>
>>   		tc->send(sock, sendbuf, 1, 0);
>> -		ret = check_recv(dst_sock, SENDSIZE + 1);
>> +		ret = check_recv(dst_sock, SENDSIZE + 1, i + 1);
>>
>>   		if (!ret)
>>   			break;
>>
>
>
>
> .
>



