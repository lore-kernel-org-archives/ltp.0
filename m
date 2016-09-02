From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Fri, 2 Sep 2016 17:12:32 +0300
Subject: [LTP] [PATCH] lsmod01: parse a copy of /proc/modules
In-Reply-To: <20160831135545.GB7346@rei.lan>
References: <1472468916-13152-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <20160831135545.GB7346@rei.lan>
Message-ID: <57C988D0.5040202@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

On 08/31/2016 04:55 PM, Cyril Hrubis wrote:
> Hi!
> Thinking of this again, why don't we just compare the first two fields
> of the output?
> 

I thought it would be an unnecessary narrowing of the test scope, i.e.
why test 2 fields if we can test 3.
