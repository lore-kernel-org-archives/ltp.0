From: Xiao Yang <ice_yangxiao@163.com>
Date: Mon, 19 Apr 2021 18:17:06 +0800
Subject: [LTP] [PATCH v2 1/2] include/tst_test_macros.h: Add TST_EXP_PID
 and TST_EXP_PID_SILENT macros
In-Reply-To: <YH1EJ8BmbYTBOvdk@yuki>
References: <20210419044112.31443-1-ice_yangxiao@163.com>
 <YH1EJ8BmbYTBOvdk@yuki>
Message-ID: <70c0c22a-97ba-a647-9ae8-998e2469927e@163.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

Thanks, pushed with your suggestion(use TST_EXP_POSITIVE).

Best Regards,

Xiao Yang

On 4/19/21 4:49 PM, Cyril Hrubis wrote:
> Maybe we should rename the TST_EXP_FD_SILENT() to TST_EXP_POSITIVE() and
> then define both TST_EXP_PID_SILENT() and TST_EXP_FD_SILENT() based on
> TST_EXP_POSITIVE(), but that's very minor.
>
> Looks good to me:
>
> Reviewed-by: Cyril Hrubis<chrubis@suse.cz>

