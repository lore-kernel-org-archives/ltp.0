From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 28 Nov 2019 16:34:16 +0100
Subject: [LTP] [PATCH 2/2] network/iptables: add new test for
 iptables-tranlsate and nft
In-Reply-To: <81a49496-28c9-2057-7366-8e4d8665644b@oracle.com>
References: <20191126115344.15926-1-alexey.kodanev@oracle.com>
 <20191126115344.15926-2-alexey.kodanev@oracle.com>
 <20191128104603.GA3216@dell5510>
 <81a49496-28c9-2057-7366-8e4d8665644b@oracle.com>
Message-ID: <20191128153416.GA5219@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> > But for nft01.sh I got error:
> > nft01 1 TINFO: INIT: Flushing all rules.
> > nft01 1 TCONF: nft not applicable for test 1
> > nft01 2 TINFO: Use nft to DROP packets from particular IP
> > nft01 2 TINFO: Rule to block icmp from 127.0.0.1
> > nft01 2 TFAIL: nft command failed to append new rule.
> > Error: Could not process rule: No such file or directory
> > add rule ip filter INPUT ip protocol icmp ip saddr 127.0.0.1 counter drop
> > ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

> It seems there is no ip filter table with INPUT chain? firewalld not installed?
No, firewalld it's installed on openSUSE (+ I'll test it for Debian, but I
expect the same result).

> Is it test running fine after these:

> # nft add table ip filter
> # nft add chain ip filter INPUT '{ type filter hook input priority 0; }'

Kind regards,
Petr
