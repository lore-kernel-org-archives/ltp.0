From: Li Wang <liwang@redhat.com>
Date: Wed, 31 Jul 2019 15:16:18 +0800
Subject: [LTP] [PATCH] zram01: Fix division by 0
In-Reply-To: <20190731063320.4898-1-pvorel@suse.cz>
References: <20190731063320.4898-1-pvorel@suse.cz>
Message-ID: <CAEemH2f5XQZw-1hP7ffNYFUtPcBW7TujgkGjN5T0NBa5gnx_AQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> +       if [ $used_mem -eq 0 ]; then
> +               tst_resm TBROK "no memory used by zram"
> +               return
> +       fi

Why not use tst_brkm directly? Otherwise looks good to me.

-- 
Regards,
Li Wang
