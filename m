From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 18 Oct 2019 15:45:26 +0200
Subject: [LTP] [PATCH] lsmod01.sh: retry test couple times to lower
 false positives
In-Reply-To: <c8843f2f4a325e820d030d9c7c36d7624f1baa82.1571393044.git.jstancek@redhat.com>
References: <c8843f2f4a325e820d030d9c7c36d7624f1baa82.1571393044.git.jstancek@redhat.com>
Message-ID: <20191018134525.GA2589@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan,

...
>  	if [ "$lsmod_output" != "$modules_output" ]; then
> -		tst_res TFAIL "lsmod output different from /proc/modules."
> +		tst_res TINFO "lsmod output different from /proc/modules."

>  		echo "$lsmod_output" > temp1
>  		echo "$modules_output" > temp2
>  		diff temp1 temp2
Also this code could be wrapped with
if tst_cmd_available diff; then

(I wouldn't add it to TST_NEEDS_CMDS)

Kind regards,
Petr
