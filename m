From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 26 Nov 2015 14:24:40 +0300
Subject: [LTP] [PATCH V5] controllers/pids: Add new testcases
In-Reply-To: <1448532423-767-1-git-send-email-chnyda@suse.com>
References: <1448532423-767-1-git-send-email-chnyda@suse.com>
Message-ID: <5656EBF8.3080604@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 11/26/2015 01:07 PM, Cedric Hnyda wrote:
> Created new testcases to test the pids controller
> which is used to stop any new tasks from being fork()'d
> after a certain limit is reached.
>
>
> +
> +usage()
> +{
> +	echo "usage: ./pids01 caseno max"
> +	tst_resm TFAIL "invalid parameters"

The messages could be merged into one, no need to print two:

tst_resm TFAIL "invalid parameters, usage: ..."

> +
> +start_pids_tasks2()
> +{
> +	nb=$1
> +	for i in `seq 1 $nb`; do
> +		pids_task2 &
> +		echo $! > $testpath/tasks
> +	done
> +
> +	if [ $(cat "$testpath/tasks" | wc -l) -ne $nb ]; then
> +		tst_resm TBROK "..."

Please make it more informative :)

Thanks,
Alexey
