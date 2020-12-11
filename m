From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 11 Dec 2020 09:54:42 +0100
Subject: [LTP] [PATCH 1/2] lib/tst_net.sh: add getopts to tst_ping()
In-Reply-To: <20201208162440.14538-1-alexey.kodanev@oracle.com>
References: <20201208162440.14538-1-alexey.kodanev@oracle.com>
Message-ID: <X9Mz0gJZ4PiNBEBt@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> * Replace '-i 0' with '-f'

> * Add similar checks for the flood and interval options as
>   in ping02 test

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Did a brief testing for both iputils ping and busybox ping.

Kind regards,
Petr
