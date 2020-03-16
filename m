From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon, 16 Mar 2020 11:39:50 +0530
Subject: [LTP] [PATCH V6 05/10] syscalls/fsconfig: New tests
In-Reply-To: <20200313120943.GA32033@dell5510>
References: <cover.1584014172.git.viresh.kumar@linaro.org>
 <824c287cd06190cf0a489535fd4617aff8742b03.1584014172.git.viresh.kumar@linaro.org>
 <20200312191025.GD3803@rei.lan>
 <20200313040012.bvkzfbxlvrwkkltd@vireshk-i7>
 <20200313080334.GA6597@rei.lan>
 <20200313084853.lnfi4dnyoht5yupi@vireshk-i7>
 <20200313120943.GA32033@dell5510>
Message-ID: <20200316060950.6o52idjfocdibrn6@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 13-03-20, 13:09, Petr Vorel wrote:
> Hi Viresh,
> 
> > I didn't knew about the -i option, yeah your change makes sense now :)
> NOTE: all test (both C and shell) should support -h (inherited from the
> library), to display options.

I didn't thought about that as well earlier, but then tried -h option
with the executable earlier before your mail came and it worked. So I
assume I don't have to do anything special to support the -h option as
it is already working fine right now ?

-- 
viresh
