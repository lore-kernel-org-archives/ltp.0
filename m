From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Fri, 2 Sep 2016 12:27:57 +0300
Subject: [LTP] [PATCH 2/4] memcg_lib.sh: Move all the kill -s XXX to
	functions
In-Reply-To: <1472750315-30848-2-git-send-email-chrubis@suse.cz>
References: <1472750315-30848-1-git-send-email-chrubis@suse.cz>
 <1472750315-30848-2-git-send-email-chrubis@suse.cz>
Message-ID: <57C9461D.7030200@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

On 09/01/2016 08:18 PM, Cyril Hrubis wrote:
> This commit adds two functions:
> 
> * signal_memcg_process
>    which asks the memcg_process to allocate/free memory and waits for completition

checkpatch.pl warns that this line is too long. typo in "completition"

