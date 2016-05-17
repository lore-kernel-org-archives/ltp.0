From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 17 May 2016 14:29:09 +0200
Subject: [LTP] [PATCH v2 1/3] network: merge
 networktests.sh/networkstress.sh into network.sh
In-Reply-To: <1463475736-25258-1-git-send-email-alexey.kodanev@oracle.com>
References: <1463475736-25258-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20160517122908.GC12051@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> @@ -4,68 +4,6 @@ TST_TOTAL=1
>  TCID="network_settings"
>  . test_net.sh

We are working around the checks in test.sh here by defining TST_TOTAL
and TCID. Maybe it would be better to add the settings to separate
script sourced by the test_net.sh and here as well so that we don't have
to...

Otherwise this version looks fine.

-- 
Cyril Hrubis
chrubis@suse.cz
