From: Xiao Yang <ice_yangxiao@163.com>
Date: Mon, 30 Mar 2020 20:48:59 +0800
Subject: [LTP] [PATCH v3 1/3] security/dirtyc0w: Fix bug caused by
 default umask
In-Reply-To: <20200330092046.GB9845@yuki.lan>
References: <1585553269-119544-1-git-send-email-zou_wei@huawei.com>
 <1585553269-119544-2-git-send-email-zou_wei@huawei.com>
 <20200330091835.GA9845@yuki.lan> <20200330092046.GB9845@yuki.lan>
Message-ID: <f78cb609-b4f1-2f89-a641-09a97c2d0a03@163.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril, Petr

Just one question when reviewing this patch set.

I saw the umask set(e.g. set umask to 0 or 0022) is used by a lot of tests.

Is it necessary for metadata project to introduce .needs_umask?

Thanks,

Xiao Yang

On 3/30/20 5:20 PM, Cyril Hrubis wrote:
> Hi!
>>> The case is only successful when system default umask is 0022.
>>> When default umask is 0077 or other values, should clear current umask by umask(0) in setup().
>> What exactly fails in the dirtyc0w because of non-standard umask?
>>
>> I can easily understand why fstat and statx fail, since we check the
>> file permissions there. Ideally the failure should have been part of the
>> patch description.
> Looking at the code I guess that the child fails to open the file
> created in parent before the setgid/setuid, something like this should
> really have been part of the patch description.
>

