From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 27 Sep 2017 13:39:43 +0200
Subject: [LTP] [PATCH] utimensat_tests.sh: returns EPERM on 4.4.27 and
 above
In-Reply-To: <20170925144624.GB31931@rei>
References: <1504697434-22974-1-git-send-email-naresh.kamboju@linaro.org>
 <1059184676.9072017.1504698860809.JavaMail.zimbra@redhat.com>
 <CAO_48GG9k_MxhktOWptCkv1Y8xFfFN31w2ntcnkZL5LdhM7qxg@mail.gmail.com>
 <20170925144624.GB31931@rei>
Message-ID: <20170927113943.GA25779@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> The safest bet would be allowing both for kernels between 4.4 and 4.8.
> 
> Something like this may work (beware untested):

And I've just checked the patch, it seems to work fine for me.

Can anybody else test this before it gets commited?

> diff --git a/testcases/kernel/syscalls/utimensat/utimensat_tests.sh b/testcases/kernel/syscalls/utimensat/utimensat_tests.sh
> index 48154d6e6..41ea7997a 100755
> --- a/testcases/kernel/syscalls/utimensat/utimensat_tests.sh
> +++ b/testcases/kernel/syscalls/utimensat/utimensat_tests.sh
> @@ -31,13 +31,18 @@ if tst_kvcmp -lt "2.6.22"; then
>  fi
>  
>  # Starting with 4.8.0 operations on immutable files return EPERM instead of
> -# EACCES.
> -if tst_kvcmp -lt "4.8.0"; then
> +# EACCES. The patch that changed the errno got as well backported to stable
> +# kernel branches and so we cannot really say what is correct for kernels in
> +# the range between 4.4 and 4.8.
> +imaccess="EACCES EPERM"
> +
> +if tst_kvcmp -lt "4.4"; then
>  	imaccess=EACCES
> -else
> -	imaccess=EPERM
>  fi
>  
> +if tst_kvcmp -ge "4.8"; then
> +	imaccess=EPERM
> +fi
>  
>  RESULT_FILE=$TMPDIR/utimensat.result
>  
> @@ -142,7 +147,13 @@ check_result()
>           "$EXPECT_MTIME_CHANGED"
>      echo "RESULT:   $res $atime $mtime"
>  
> -    if test "$res" != "$EXPECTED_RESULT"; then
> +    for err in $EXPECTED_RESULT; do
> +	if test "$res" = "$err"; then
> +	    errno_found="$err";
> +	fi
> +    done
> +
> +    if test -z "$errno_found"; then
>          test_failed
>          return
>      fi
> @@ -223,7 +234,7 @@ run_test()
>      CMD="./$TEST_PROG -q $FILE $4"
>      echo "$CMD"
>      sudo $s_arg -u $test_user $CMD > $RESULT_FILE
> -    check_result $? $5 $6 $7
> +    check_result $? "$5" $6 $7
>      echo
>  
>      if test $do_read_fd_test -ne 0; then
> @@ -232,7 +243,7 @@ run_test()
>          CMD="./$TEST_PROG -q -d $FILE NULL $4"
>          echo "$CMD"
>          sudo $s_arg -u $test_user $CMD > $RESULT_FILE
> -        check_result $? $5 $6 $7
> +        check_result $? "$5" $6 $7
>          echo
>      fi
>  
> @@ -245,7 +256,7 @@ run_test()
>          CMD="./$TEST_PROG -q -w -d $FILE NULL $4"
>          echo "$CMD"
>          sudo $s_arg -u $test_user $CMD > $RESULT_FILE
> -        check_result $? $5 $6 $7
> +        check_result $? "$5" $6 $7
>          echo
>      fi
>  
> @@ -424,10 +435,10 @@ echo "Testing immutable file, owned by self"
>  echo
>  
>  echo "***** Testing times==NULL case *****"
> -run_test -W "" 600 "+i" "" $imaccess
> +run_test -W "" 600 "+i" "" "$imaccess"
>  
>  echo "***** Testing times=={ UTIME_NOW, UTIME_NOW } case *****"
> -run_test -W "" 600 "+i" "0 n 0 n" $imaccess
> +run_test -W "" 600 "+i" "0 n 0 n" "$imaccess"
>  
>  echo "***** Testing times=={ UTIME_OMIT, UTIME_OMIT } case *****"
>  run_test -W "" 600 "+i" "0 o 0 o" SUCCESS n n
> @@ -450,10 +461,10 @@ echo "Testing immutable append-only file, owned by self"
>  echo
>  
>  echo "***** Testing times==NULL case *****"
> -run_test -W "" 600 "+ai" "" $imaccess
> +run_test -W "" 600 "+ai" "" "$imaccess"
>  
>  echo "***** Testing times=={ UTIME_NOW, UTIME_NOW } case *****"
> -run_test -W "" 600 "+ai" "0 n 0 n" $imaccess
> +run_test -W "" 600 "+ai" "0 n 0 n" "$imaccess"
>  
>  echo "***** Testing times=={ UTIME_OMIT, UTIME_OMIT } case *****"
>  run_test -W "" 600 "+ai" "0 o 0 o" SUCCESS n n
> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
