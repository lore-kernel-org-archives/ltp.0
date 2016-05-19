From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 19 May 2016 12:54:28 +0300
Subject: [LTP] [PATCH v2 1/3] network: merge
 networktests.sh/networkstress.sh into network.sh
In-Reply-To: <20160517135345.GF12051@rei.lan>
References: <1463475736-25258-1-git-send-email-alexey.kodanev@oracle.com>
 <20160517122908.GC12051@rei.lan> <573B1822.3030601@oracle.com>
 <20160517135345.GF12051@rei.lan>
Message-ID: <573D8D54.3050507@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

Applied v2 with some minor changes:
* correctly set LTPROOT variable before sourcing test.sh;
* added usage help for network.sh.

Thanks,
Alexey

