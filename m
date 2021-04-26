From: Li Wang <liwang@redhat.com>
Date: Mon, 26 Apr 2021 21:11:06 +0800
Subject: [LTP] [PATCH] mkfs: relax size check
In-Reply-To: <f224defc029816a74c518c54af2fbf2b90a90da6.1619176445.git.jstancek@redhat.com>
References: <f224defc029816a74c518c54af2fbf2b90a90da6.1619176445.git.jstancek@redhat.com>
Message-ID: <CAEemH2eieMfag5MDeayoeFTjn+JBuKKk8JB-bLVn6uY_SxUWhg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Apr 23, 2021 at 7:16 PM Jan Stancek <jstancek@redhat.com> wrote:
>
> Number of total data blocks in filesystem reported by statfs
> may be less than current formula of 90%. For example ext4 will
> subtract "s_first_data_block plus internal journal blocks".
>
> With recent change to e2fsprogs, overhead calculated in user-space
> increased slightly and LTP test started failing:
>   https://github.com/tytso/e2fsprogs/commit/59037c5357d39c6d0f14a0aff70e67dc13eafc84
>
> Since there's no strict rule how much the overhead will be,
> as rule of thumb relax the condition to 80%.
>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>

Reviewed-by: Li Wang <liwang@redhat.com>


-- 
Regards,
Li Wang

