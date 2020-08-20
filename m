From: Li Wang <liwang@redhat.com>
Date: Thu, 20 Aug 2020 17:15:43 +0800
Subject: [LTP] [PATCH v2 1/3] hotplug/memory_hotplug: Handle NULL
 returned by strtok_r when parsing inputs
In-Reply-To: <20200811180604.4073173-1-aiden.gaoyuan@gmail.com>
References: <20200811180604.4073173-1-aiden.gaoyuan@gmail.com>
Message-ID: <CAEemH2dxX2-t7S0TN3p7=zMLY_=TquSZdKUgqDRE9fpg_t8hdA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Yuan,

Thanks for contributing to the memory-hotplug test. I have no objection to
these patches, but it seems quite a long time(since it imported to LTP from
Linux foundation at the year 2008) nobody actually touches this
memtoy except some code cleanup work.

I'm wondering whether you guys play with the memtoy regularly? and how do
you use it?

I take a rough look at the README file but got nothing useful to get
a start.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200820/0cedfc7c/attachment.htm>
