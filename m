From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 13 Jan 2021 11:11:03 +0100
Subject: [LTP] [PATCH v2 0/3] Build fix undefined struct file_handle
In-Reply-To: <X/7EIYub09rxaobQ@yuki.lan>
References: <20210113075110.31628-1-pvorel@suse.cz> <X/7EIYub09rxaobQ@yuki.lan>
Message-ID: <X/7HN0PTJq6zkBze@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril, Xu,

> Hi!
> Looks good to me.

> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

Thanks for your reviews, merged (with change pointed out by Xu: remove <fcntl.h>
from all fanotify tests).

Kind regards,
Petr
