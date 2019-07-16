From: Xiao Yang <ice_yangxiao@163.com>
Date: Tue, 16 Jul 2019 22:04:17 +0800
Subject: [LTP] [PATCH] syscalls/acct02.c: Read threshold from
 /proc/sys/kernel/acct
In-Reply-To: <20190715160010.GA30303@rei.lan>
References: <1563203796-22102-1-git-send-email-ice_yangxiao@163.com>
 <20190715160010.GA30303@rei.lan>
Message-ID: <02b9f80d-05ec-e837-5770-c12f73f6bb0f@163.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 07/16/2019 12:00 AM, Cyril Hrubis wrote:
> Hi!
>> Don't use hardcoded threshold(default 4%) to check free space
>> because it can be changed by writing "/proc/sys/kernel/acct"
>> or using sysctl.
> Good catch, I missed the sysctl API since I haven't realized that the
> proc handlers are all stuffed in a different file in kernel/sysctl.c.
>
> What about we as well temporarily lower the value if needed while the
> test is running?
Hi Cyril,

When free space is not enough, test can change the threshold by itself
or remind user to modify the threshold by sysctl API manually.

Which one do you prefer?

Best Regards,
Xiao Yang
>


