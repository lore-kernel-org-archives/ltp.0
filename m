From: Li Wang <liwang@redhat.com>
Date: Thu, 2 Jul 2020 18:08:16 +0800
Subject: [LTP] [PATCH] numa01.sh: Fix parsing numastat for given node
In-Reply-To: <20200702095029.35220-1-harish@linux.ibm.com>
References: <20200702095029.35220-1-harish@linux.ibm.com>
Message-ID: <CAEemH2cMx601hD3u_MGME3phSPmUggzCepk46BLkAqChZ0LRog@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Jul 2, 2020 at 5:51 PM Harish <harish@linux.ibm.com> wrote:

> In few systems, the node numbering is not necessarily ordered.
> E.g.
>
> Per-node process memory usage (in MBs) for PID 2069 (systemd-udevd)
>                            Node 0          Node 8           Total
>                   --------------- --------------- ---------------
> ...
> ...
> ----------------  --------------- --------------- ---------------
> Total                       17.50            0.00           17.50
>
> Patch fixes parsing numastat for given node by finding its awk
> index so that proper value is utilized in the test.
>

Thanks for fixing this Harish, but I'm afraid you have to rebase your code
on Petr's last patch.
http://lists.linux.it/pipermail/ltp/2020-July/017893.html

Anyway, this patch makes sense to me.



>
> Signed-off-by: Harish <harish@linux.ibm.com>
> ---
>  testcases/kernel/numa/numa01.sh | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/testcases/kernel/numa/numa01.sh
> b/testcases/kernel/numa/numa01.sh
> index 1d626327d..fd437cd15 100755
> --- a/testcases/kernel/numa/numa01.sh
> +++ b/testcases/kernel/numa/numa01.sh
> @@ -25,15 +25,26 @@ TST_NEEDS_CMDS="awk bc numactl numastat"
>
>  . tst_test.sh
>
> +# Awk the field matching the node value for numastat
> +# $1 - Pid number
> +# $2 - Node number
> +get_node_index()
> +{
> +       local pid=$1
> +       local nid="Node $2"
> +       echo $(numastat -p $pid | sed '3q;d' | awk -F
> '[[:space:]][[:space:]]+' \
> +               -v node="$nid" '{ for (i = 1; i <= NF; ++i) if($i==node)
> print i; exit }')
> +}
> +
>  # Extracts the value of given numa node from the `numastat -p` output.
>  # $1 - Pid number.
>  # $2 - Node number.
>  extract_numastat_p()
>  {
>         local pid=$1
> -       local node=$(($2 + 2))
> +       local index=$(echo "$(get_node_index $pid $2)")
>
> -       echo $(numastat -p $pid |awk '/^Total/ {print $'$node'}')
> +       echo $(numastat -p $pid |awk '/^Total/ {print $'$index'}')
>  }
>
>  check_for_support_numa()
> @@ -341,8 +352,8 @@ test9()
>                 numactl --cpunodebind=$node --membind=$node support_numa
> alloc_1huge_page &
>                 pid=$!
>                 TST_RETRY_FUNC "check_for_support_numa $pid" 0
> -
> -               Mem_huge=$(echo $(numastat -p $pid |awk '/^Huge/ {print
> $'$((node+2))'}'))
> +               local index=$(echo "$(get_node_index $pid $node)")
> +               Mem_huge=$(echo $(numastat -p $pid |awk '/^Huge/ {print
> $'$index'}'))
>                 Mem_huge=$((${Mem_huge%.*} * 1024))
>
>                 if [ "$Mem_huge" -lt "$HPAGE_SIZE" ]; then
> --
> 2.25.4
>
>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200702/9d3a1dc3/attachment.htm>
