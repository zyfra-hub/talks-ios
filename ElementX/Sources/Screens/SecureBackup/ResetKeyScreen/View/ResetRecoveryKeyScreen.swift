//
// Copyright 2022 New Vector Ltd
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import Compound
import SwiftUI

struct ResetRecoveryKeyScreen: View {
    @ObservedObject var context: ResetRecoveryKeyScreenViewModel.Context
    
    var body: some View {
        NavigationStack {
            FullscreenDialog {
                mainContent
            } bottomContent: {
                EmptyView()
            }
            .toolbar { toolbar }
            .toolbar(.visible, for: .navigationBar)
            .background()
            .environment(\.backgroundStyle, AnyShapeStyle(Color.compound.bgSubtleSecondary))
            .interactiveDismissDisabled()
        }
    }
    
    private var mainContent: some View {
        VStack(spacing: 40) {
            header
            list
        }
    }
    
    private var header: some View {
        VStack(spacing: 16) {
            HeroImage(icon: \.computer, style: .subtle)
            
            Text(L10n.screenCreateNewRecoveryKeyTitle)
                .foregroundColor(.compound.textPrimary)
                .font(.compound.headingMDBold)
                .multilineTextAlignment(.center)
        }
    }
    
    private var list: some View {
        VStack(alignment: .leading, spacing: 24) {
            Label {
                Text(L10n.screenCreateNewRecoveryKeyListItem1)
            } icon: {
                Image(systemSymbol: ._1Circle)
                    .imageScale(.large)
                    .fontWeight(.light)
                    .foregroundColor(.compound.textPlaceholder)
            }
            .foregroundColor(.compound.textPrimary)
            .font(.compound.bodyMD)
            
            Label {
                Text(L10n.screenCreateNewRecoveryKeyListItem2)
            } icon: {
                Image(systemSymbol: ._2Circle)
                    .imageScale(.large)
                    .fontWeight(.light)
                    .foregroundColor(.compound.textPlaceholder)
            }
            .foregroundColor(.compound.textPrimary)
            .font(.compound.bodyMD)
            
            Label {
                Text(context.viewState.listItem3AttributedText)
            } icon: {
                Image(systemSymbol: ._3Circle)
                    .imageScale(.large)
                    .fontWeight(.light)
                    .foregroundColor(.compound.textPlaceholder)
            }
            .foregroundColor(.compound.textPrimary)
            .font(.compound.bodyMD)
            
            Label {
                Text(L10n.screenCreateNewRecoveryKeyListItem4)
            } icon: {
                Image(systemSymbol: ._4Circle)
                    .imageScale(.large)
                    .fontWeight(.light)
                    .foregroundColor(.compound.textPlaceholder)
            }
            .foregroundColor(.compound.textPrimary)
            .font(.compound.bodyMD)
            
            Label {
                Text(L10n.screenCreateNewRecoveryKeyListItem5)
            } icon: {
                Image(systemSymbol: ._5Circle)
                    .imageScale(.large)
                    .fontWeight(.light)
                    .foregroundColor(.compound.textPlaceholder)
            }
            .foregroundColor(.compound.textPrimary)
            .font(.compound.bodyMD)
        }
    }
    
    @ToolbarContentBuilder
    private var toolbar: some ToolbarContent {
        ToolbarItem(placement: .cancellationAction) {
            Button(L10n.actionCancel) {
                context.send(viewAction: .cancel)
            }
        }
    }
}

// MARK: - Previews

struct ResetRecoveryKeyScreen_Previews: PreviewProvider, TestablePreview {
    static let viewModel = ResetRecoveryKeyScreenViewModel()
    static var previews: some View {
        NavigationStack {
            ResetRecoveryKeyScreen(context: viewModel.context)
        }
    }
}
