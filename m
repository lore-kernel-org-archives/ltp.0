From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 8 Mar 2021 15:18:48 +0100
Subject: [LTP] [PATCH 3/6] fzsync: Correctly print positive lower delay
 range bound
In-Reply-To: <20210305155123.18199-4-rpalethorpe@suse.com>
References: <20210305155123.18199-1-rpalethorpe@suse.com>
 <20210305155123.18199-4-rpalethorpe@suse.com>
Message-ID: <YEYySNks6oNJI3Dk@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> If the magnitude of delay_bias is large enough then it can turn the
> lower bound positive.
> 
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz
