From: Matthew Wilcox <willy@infradead.org>
Date: Mon, 22 Mar 2021 09:05:36 +0000
Subject: [LTP] [net] 5478fcd0f4:
 BUG:sleeping_function_called_from_invalid_context_at_include/linux/sched/mm.h
In-Reply-To: <161640335063.3537.6668586361113979688@kwain.local>
References: <20210322083553.GI32426@xsang-OptiPlex-9020>
 <161640335063.3537.6668586361113979688@kwain.local>
Message-ID: <20210322090536.GK1719932@casper.infradead.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Mar 22, 2021 at 09:55:50AM +0100, Antoine Tenart wrote:
> I only had a quick look at this, but I think the issue should be fixed
> with:
> 
> diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> index e16d54aabd4c..3ae3c20eb64c 100644
> --- a/net/core/net-sysfs.c
> +++ b/net/core/net-sysfs.c
> @@ -1378,7 +1378,7 @@ static ssize_t xps_queue_show(struct net_device *dev, unsigned int index,
>         nr_ids = dev_maps ? dev_maps->nr_ids :
>                  (type == XPS_CPUS ? nr_cpu_ids : dev->num_rx_queues);
>  
> -       mask = bitmap_zalloc(nr_ids, GFP_KERNEL);
> +       mask = bitmap_zalloc(nr_ids, GFP_ATOMIC);
>         if (!mask) {
>                 rcu_read_unlock();
>                 return -ENOMEM;

sysfs isn't a good reason to use GFP_ATOMIC.

try something like this:

-       mask = bitmap_zalloc(nr_ids, GFP_KERNEL);
+       mask = bitmap_zalloc(nr_ids, GFP_NOWAIT);
        if (!mask) {
+               int new_nr_ids;
+
                rcu_read_unlock();
-               return -ENOMEM;
+               mask = bitmap_zalloc(nr_ids, GFP_KERNEL);
+               if (!mask)
+                       return -ENOMEM;
+               rcu_read_lock();
+               dev_maps = rcu_dereference(dev->xps_maps[type]);
+               /* if nr_ids shrank while we slept, do not overrun array.
+                * if it increased, we just won't show the new ones
+                */
+               new_nr_ids = dev_maps ? dev_maps->nr_ids :
+                       (type == XPS_CPUS ? nr_cpu_ids : dev->num_rx_queues);
+               if (new_nr_ids < nr_ids)
+                       nr_ids = new_nr_ids;

