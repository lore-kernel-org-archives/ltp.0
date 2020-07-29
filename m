From: Xiao Yang <ice_yangxiao@163.com>
Date: Wed, 29 Jul 2020 21:05:08 +0800
Subject: [LTP] [PATCH] hotplug/memory_hotplug: Remove unused goto label
In-Reply-To: <20200727164355.1177602-1-aiden.gaoyuan@gmail.com>
References: <20200727164355.1177602-1-aiden.gaoyuan@gmail.com>
Message-ID: <62530509-aba6-9180-ecea-150f3c5b8ebb@163.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 7/28/20 12:43 AM, aidengao wrote:
> From: aidengao <aidengao@google.com>
>
> Remove unused goto label in parse_command_line_args function
>
> Signed-off-by: Yuan Gao <aiden.gaoyuan@gmail.com>
> ---
>   testcases/kernel/hotplug/memory_hotplug/memtoy.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/testcases/kernel/hotplug/memory_hotplug/memtoy.c b/testcases/kernel/hotplug/memory_hotplug/memtoy.c
> index 8ac9600de..90bfd7f2f 100644
> --- a/testcases/kernel/hotplug/memory_hotplug/memtoy.c
> +++ b/testcases/kernel/hotplug/memory_hotplug/memtoy.c
> @@ -447,7 +447,7 @@ int parse_command_line_args(int argc, char *argv[])
>   			break;
>   		}
>   	}
> -done:
> +
>   

Hi Gao,

Pushed with a minor change(delete a redundant blank line). :-)

Thanks,

Xiao Yang

>   	return (error);
>   }

