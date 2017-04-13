From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 13 Apr 2017 11:32:03 +0200
Subject: [LTP] [PATCH 1/2] dns-stress: fix test and use locally defined
 IP addresses
In-Reply-To: <1491900299-8615-1-git-send-email-alexey.kodanev@oracle.com>
References: <1491900299-8615-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20170413093203.2nghwk4xb53ff6s5@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,


> * define IP addresses, which are used in DNS query/answer,
>   inside the test. It should be safe to use any network
>   as we run 'named' on a non-standard port

> * remove *_REV env variables from test_net.sh

> * remove useless ping test inside setup()

> * options section in conf provides directory path for 'named' that's
>   why we don't need to specify full path for named.pid file

> * remove 'client' A/AAAA records as they don't used in the test

> * fix calculation of IPv6 host part reverse address

> * remove TST_TMPDIR usage, use cwd

> * add printing port number on which 'named' is listening

> * sleep 100ms instead of 1sec when waiting for dns server

> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>

LGTM :-). Thanks for simplifying the stuff for my patch simplifying network setup.


Kind regards,
Petr
