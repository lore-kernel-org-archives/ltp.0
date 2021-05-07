From: Li Wang <liwang@redhat.com>
Date: Fri, 7 May 2021 11:10:38 +0800
Subject: [LTP] LTP Release
In-Reply-To: <YJOYgZNL7/qp5YCN@yuki>
References: <YJOYgZNL7/qp5YCN@yuki>
Message-ID: <CAEemH2dPMc+XoOXokm6K9w07QK2p-y8ZWOiwbQRAQGLmnhMkmg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

I vote to fix the brk02 FAIL as Liam suggests way (just removing
'PROT_WRITE|PROT_EXEC'), but I'm still a bit hesitant if that's wise
for the test, or we can leave this problem for a long time to investigate.

https://lists.linux.it/pipermail/ltp/2021-May/022474.html


--
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210507/e26818c0/attachment.htm>
