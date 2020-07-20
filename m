From: Xiao Yang <ice_yangxiao@163.com>
Date: Mon, 20 Jul 2020 19:24:54 +0800
Subject: [LTP] [PATCH v4] syscalls/pidfd_open01.c: Add check for
 close-on-exec flag
In-Reply-To: <20200720085311.h77zxzfsqrhmmy2w@vireshk-mac-ubuntu>
References: <20200720052755.21105-1-yangx.jy@cn.fujitsu.com>
 <20200720085311.h77zxzfsqrhmmy2w@vireshk-mac-ubuntu>
Message-ID: <19b160e1-be12-bb32-a2cd-1c2be24428cb@163.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr, Viresh

Thanks a lot for your review, pushed. :-)

Thanks,

Xiao Yang

On 7/20/20 4:53 PM, Viresh Kumar wrote:
> On 20-07-20, 13:27, Xiao Yang wrote:
>> pidfd_open(2) will set close-on-exec flag on the file descriptor as
>> it manpage states, so check close-on-exec flag by fcntl(2).
>>
>> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
>> ---
>>
>> 1) We don't care if the test uses the TEST() macro so just keep it.
>> 2) Use bare fcntl() instead of SAFE_FCNTL() so that file descriptor
>>     can be closed when fcntl(F_GETFD) fails.
>>
>>   .../kernel/syscalls/pidfd_open/pidfd_open01.c  | 18 ++++++++++++++++--
>>   1 file changed, 16 insertions(+), 2 deletions(-)
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>

