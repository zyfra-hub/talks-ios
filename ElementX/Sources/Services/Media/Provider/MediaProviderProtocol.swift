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

import Foundation
import UIKit

enum MediaProviderError: Error {
    case failedRetrievingImage
    case failedRetrievingFile
    case invalidImageData
    case failedRetrievingThumbnail
}

protocol MediaProviderProtocol: ImageProviderProtocol {
    func loadFileFromSource(_ source: MediaSourceProxy, body: String?) async -> Result<MediaFileHandleProxy, MediaProviderError>
    func loadThumbnailForSource(source: MediaSourceProxy, size: CGSize) async -> Result<Data, MediaProviderError>
}

extension MediaProviderProtocol {
    func loadFileFromSource(_ source: MediaSourceProxy) async -> Result<MediaFileHandleProxy, MediaProviderError> {
        await loadFileFromSource(source, body: nil)
    }
}
