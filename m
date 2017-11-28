From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 28 Nov 2017 23:36:15 +0100
Subject: [LTP] [PATCH] ipsec: fix vti ipcomp test-cases
In-Reply-To: <1511881504-13160-1-git-send-email-alexey.kodanev@oracle.com>
References: <1511881504-13160-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20171128223615.4u5tl6icpmzz6byc@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,
> VTI is not designed to handle ipcomp when packets sent without
> transformation, see also: https://patchwork.ozlabs.org/patch/840445/

> Adjust test-cases so that ipcomp header always used.
                                          ^ Do you mean never?

> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>

Acked-by: Petr Vorel <pvorel@suse.cz>

Thanks for taking care of it!

Kind regards,
Petr
