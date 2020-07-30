From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 30 Jul 2020 12:01:52 +0800
Subject: [LTP] [PATCH v2] hotplug/memory_hotplug: Remove unused goto
 label
In-Reply-To: <20200729185344.3318703-1-aiden.gaoyuan@gmail.com>
References: <20200729185344.3318703-1-aiden.gaoyuan@gmail.com>
Message-ID: <5F224630.7090600@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

I have pushed with this change, so you don't need to send the v2 path.

Thanks,
Xiao Yang
On 2020/7/30 2:53, Yuan Gao wrote:
> Remove unused goto label in parse_command_line_args function
>
> Change from v1
> 1. Remove a redundant blank line
>
> Signed-off-by: Yuan Gao<aiden.gaoyuan@gmail.com>
> ---
>   testcases/kernel/hotplug/memory_hotplug/memtoy.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/testcases/kernel/hotplug/memory_hotplug/memtoy.c b/testcases/kernel/hotplug/memory_hotplug/memtoy.c
> index 8ac9600de..e647f86b6 100644
> --- a/testcases/kernel/hotplug/memory_hotplug/memtoy.c
> +++ b/testcases/kernel/hotplug/memory_hotplug/memtoy.c
> @@ -447,7 +447,6 @@ int parse_command_line_args(int argc, char *argv[])
>   			break;
>   		}
>   	}
> -done:
>
>   	return (error);
>   }



