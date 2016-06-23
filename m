From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 23 Jun 2016 14:58:45 +0300
Subject: [LTP] [PATCH 1/2] lib: add safe_gethostname()
In-Reply-To: <20160622120535.GB13962@rei.lan>
References: <1466076425-12790-1-git-send-email-alexey.kodanev@oracle.com>
 <20160622120535.GB13962@rei.lan>
Message-ID: <576BCEF5.3090509@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 06/22/2016 03:05 PM, Cyril Hrubis wrote:
> Hi!
>> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
>> ---
>>   include/safe_net_fn.h  |    3 +++
>>   include/tst_safe_net.h |    3 +++
>>   lib/safe_net.c         |   14 ++++++++++++++
>>   3 files changed, 20 insertions(+), 0 deletions(-)
>>
>> diff --git a/include/safe_net_fn.h b/include/safe_net_fn.h
>> index e85842b..14609b8 100644
>> --- a/include/safe_net_fn.h
>> +++ b/include/safe_net_fn.h
>> @@ -45,4 +45,7 @@ int safe_getsockname(const char *file, const int lineno,
>>   		     void (cleanup_fn)(void), int sockfd, struct sockaddr *addr,
>>   		     socklen_t *addrlen);
>>   
>> +int safe_gethostname(const char *file, const int lineno,
>> +		     void (cleanup_fn)(void), char *name, size_t size);
>> +
> What about not including the cleanup_fn parameter, since the function is
> exported only to new library?

Yes, in newlib it's not used, I'll remove it.

Thanks,
Alexey
