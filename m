From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 23 Aug 2018 09:22:32 -0400 (EDT)
Subject: [LTP] [RFC PATCH 2/2] make: Add test target
In-Reply-To: <20180821140547.2509-3-pvorel@suse.cz>
References: <20180821140547.2509-1-pvorel@suse.cz>
 <20180821140547.2509-3-pvorel@suse.cz>
Message-ID: <87678476.42057848.1535030552166.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  Makefile           |  3 +++
>  lib/tests/Makefile |  3 +++
>  lib/tests/test.sh  | 32 ++++++++++++++++++++++++++++++++
>  3 files changed, 38 insertions(+)
>  create mode 100755 lib/tests/test.sh
> +
> +for i in $@; do
> +    echo "=== Testing '$i' ==="
> +    case $i in
> +        tst_checkpoint_wake_timeout|tst_record_childstatus)
> +        if [ "$i" = "tst_record_childstatus" ]; then
> +            echo "NOTE: expecting fail the test"
> +            ./$i || [ $? -eq 1 ]
> +        fi

I'd prefer we fix the tests and make them return 0 if everything goes as expected.

Regards,
Jan

