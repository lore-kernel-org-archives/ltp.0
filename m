From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 6 May 2021 15:02:24 +0200
Subject: [LTP] LTP Release
In-Reply-To: <YJOYgZNL7/qp5YCN@yuki>
References: <YJOYgZNL7/qp5YCN@yuki>
Message-ID: <YJPo4L0QnXHU7xks@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

also solving Shell API timeout sleep orphan processes would be good [1]
There is already C patch [2] + Li suggested to fix the shell implementation
using trap in subshell [3].

Kind regards,
Petr

[1] https://lists.linux.it/pipermail/ltp/2021-May/022350.html
[2] https://patchwork.ozlabs.org/project/ltp/list/?series=242439
[3] https://lists.linux.it/pipermail/ltp/2021-May/022453.html
